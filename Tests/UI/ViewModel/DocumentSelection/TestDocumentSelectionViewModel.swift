/*
 * Copyright (c) 2025 European Commission
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import XCTest
import Cuckoo
import RqesKit
import RQESLib
@testable import EudiRQESUi

@MainActor
final class TestDocumentSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var viewModel: DocumentSelectionViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.viewModel = DocumentSelectionViewModel(
      router: router,
      interactor: interactor
    )
  }

  override func tearDown() async throws {
    self.interactor = nil
    self.router = nil
    self.viewModel = nil
  }

  func testInitiate_WhenGetSessionReturnSessionData_ThenReturnSuccess() async {
    // Given
    let expectedQTSPName = "Wallet-Centric"
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData,
      qtsp: TestConstants.mockQtspData
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }
    
    // When
    await viewModel.initiate()

    await fulfillment(of: [exp], timeout: 1.0)

    // Then
    let state = viewModel.viewState
    XCTAssertFalse(state.isLoading)
    XCTAssertNil(state.error)
    XCTAssertEqual(
      state.documentSelection?.mainText,
      .custom(TestConstants.mockDocumentData.documentName)
    )
    XCTAssertEqual(
      state.qtspServiceSelection?.mainText,
      .custom(expectedQTSPName)
    )
    XCTAssertEqual(
      state.certificateSelection?.mainText,
      .selectCertificate
    )
  }

  func testInitiate_WhenGetSessionReturnSessionDataWithNilQtsp_ThenReturnSuccess() async {
    // Given
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    await viewModel.initiate()

    // Then
    await fulfillment(of: [exp], timeout: 1.0)

    let state = viewModel.viewState
    XCTAssertFalse(state.isLoading)
    XCTAssertNil(state.error)
    XCTAssertEqual(
      state.documentSelection?.mainText,
      .custom(TestConstants.mockDocumentData.documentName)
    )
    XCTAssertEqual(
      state.qtspServiceSelection?.mainText,
      .selectService
    )
    XCTAssertNil(state.certificateSelection?.mainText)
  }

  func testInitiate_WhenGetSessionReturnSessionData_ThenVerifyViewDocumentCalled() async {
    // Given
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData
    )

    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    guard let action = viewModel.viewState.documentSelection?.action else {
      XCTFail("Action closure not set in documentSelection")
      return
    }

    action()

    // Then
    verify(router).navigateTo(equal(to: .viewDocument(false)))
  }

  func testInitiate_WhenGetSessionReturnSessionData_ThenVerifySelectService() async {
    // Given
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData
    )

    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    guard let action = viewModel.viewState.qtspServiceSelection?.action else {
      XCTFail("Action closure not set in documentSelection")
      return
    }

    action()

    // Then
    verify(router).navigateTo(equal(to: .serviceSelection))
  }

  func testInitiate_WhenGetSessionReturnSessionData_ThenVerifySelectCertificate() async {
    // Given
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData,
      qtsp: TestConstants.mockQtspData
    )

    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    guard let action = viewModel.viewState.certificateSelection?.action else {
      XCTFail("Action closure not set in documentSelection")
      return
    }

    action()

    // Then
    verify(router).navigateTo(equal(to: .credentialSelection))
  }

  func testErrorAction_WhenInvokedWithRetryAction_RetriesAndRecoversState() async {
    // Given
    let expectedQTSPName = "Wallet-Centric"
    let sessionWithNilDoc: SessionData = .init()
    let sessionWithDoc = SessionData(
      document: TestConstants.mockDocumentData,
      qtsp: TestConstants.mockQtspData
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(sessionWithNilDoc)
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(sessionWithNilDoc, sessionWithDoc)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    await viewModel.initiate()

    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action is nil")
      return
    }
    retryAction()

    // Then
    await fulfillment(of: [exp], timeout: 1.0)

    let state = viewModel.viewState
    XCTAssertNil(state.error)
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(
      state.documentSelection?.mainText,
      .custom(TestConstants.mockDocumentData.documentName)
    )
    XCTAssertEqual(
      state.qtspServiceSelection?.mainText,
      .custom(expectedQTSPName)
    )
    XCTAssertEqual(
      state.certificateSelection?.mainText,
      .selectCertificate
    )
  }

  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async {
    // Given
    let sessionWithNilDoc: SessionData = .init()
    let sessionWithDoc = SessionData(
      document: TestConstants.mockDocumentData,
      qtsp: TestConstants.mockQtspData
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(sessionWithNilDoc)
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(sessionWithNilDoc, sessionWithDoc)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    await viewModel.initiate()

    guard let error = viewModel.viewState.error else {
      XCTFail("Error action is nil")
      return
    }

    // Then
    await fulfillment(of: [exp], timeout: 1.0)

    XCTAssertNotNil(error)
  }

  func testInitiate_WhenGetSessionReturnSessionDataWithNilDocumentName_ThenReturnSuccess() async {
    // Given
    let expectedSession: SessionData = .init()
    let expectedError = ContentErrorView.Config(
      title: .genericErrorMessage,
      description: .genericErrorDocumentNotFound,
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    await viewModel.initiate()

    // Then

    await fulfillment(of: [exp], timeout: 1.0)

    let state = viewModel.viewState
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(state.error, expectedError)
  }

  func testViewDocument_whenRouterNavigateToViewDocument_ThenNavigateToWasCalled() async {
    // Given
    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    // When
    viewModel.viewDocument()

    // Then
    verify(router).navigateTo(equal(to: .viewDocument(false)))
  }

  func testSelectService_whenRouterNavigateToViewDocument_ThenNavigateToWasCalled() async {
    // Given
    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    // When
    viewModel.selectService()

    // Then
    verify(router).navigateTo(equal(to: .serviceSelection))
  }

  func testSelectCertificate_whenRouterNavigateToViewDocument_ThenNavigateToWasCalled() async {
    // Given
    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    // When
    viewModel.selectCertificate()

    // Then
    verify(router).navigateTo(equal(to: .credentialSelection))
  }
}
