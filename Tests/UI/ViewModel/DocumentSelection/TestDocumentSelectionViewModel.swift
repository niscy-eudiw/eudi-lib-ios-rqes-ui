/*
 * Copyright (c) 2023 European Commission
 *
 * Licensed under the EUPL, Version 1.2 or - as soon they will be approved by the European
 * Commission - subsequent versions of the EUPL (the "Licence"); You may not use this work
 * except in compliance with the Licence.
 *
 * You may obtain a copy of the Licence at:
 * https://joinup.ec.europa.eu/software/page/eupl
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the Licence is distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the Licence for the specific language
 * governing permissions and limitations under the Licence.
 */
import XCTest
import Cuckoo
import RqesKit
import RQES_LIBRARY
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
    let stateRecorder = viewModel.$viewState.record()
    let expectedQTSPName = "name"
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData,
      qtsp: QTSPData(
        name: expectedQTSPName,
        uri: URL(string: "uri")!,
        scaURL: "scaURL",
        clientId: "clientId",
        clientSecret: "clientSecret",
        authFlowRedirectionURI: "authFlowRedirectionURI",
        hashAlgorithm: "hashAlgorithm"
      )
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
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
    let stateRecorder = viewModel.$viewState.record()

    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
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
      qtsp: QTSPData(
        name: "name",
        uri: URL(string: "uri")!,
        scaURL: "scaURL",
        clientId: "clientId",
        clientSecret: "clientSecret",
        authFlowRedirectionURI: "authFlowRedirectionURI",
        hashAlgorithm: "hashAlgorithm"
      )
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

  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()

    let expectedQTSPName = "name"
    let sessionWithNilDoc: SessionData = .init()
    let sessionWithDoc = SessionData(
      document: TestConstants.mockDocumentData,
      qtsp: QTSPData(
        name: expectedQTSPName,
        uri: URL(string: "uri")!,
        scaURL: "scaURL",
        clientId: "clientId",
        clientSecret: "clientSecret",
        authFlowRedirectionURI: "authFlowRedirectionURI",
        hashAlgorithm: "hashAlgorithm"
      )
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(sessionWithNilDoc)
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(sessionWithNilDoc, sessionWithDoc)
    }

    // When
    await viewModel.initiate()

    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action is nil")
      return
    }
    retryAction()

    await waitUntil{ self.viewModel.viewState.error == nil }

    // Then
    let state = stateRecorder.fetchStates(expectedCount: 2)
    guard let firstState = state.first, let lastState = state.last else {
      XCTFail("Expected error in state, but was nil")
      return
    }
    XCTAssertNotNil(firstState.error)

    XCTAssertNil(lastState.error)
    XCTAssertFalse(lastState.isLoading)
    XCTAssertEqual(
      lastState.documentSelection?.mainText,
      .custom(TestConstants.mockDocumentData.documentName)
    )
    XCTAssertEqual(
      lastState.qtspServiceSelection?.mainText,
      .custom(expectedQTSPName)
    )
    XCTAssertEqual(
      lastState.certificateSelection?.mainText,
      .selectCertificate
    )
  }

  func testInitiate_WhenGetSessionReturnSessionDataWithNilDocumentName_ThenReturnSuccess() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    
    let expectedSession: SessionData = .init()
    let expectedError = ContentErrorView.Config(
      title: .genericErrorMessage,
      description: .genericErrorDocumentNotFound,
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
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
