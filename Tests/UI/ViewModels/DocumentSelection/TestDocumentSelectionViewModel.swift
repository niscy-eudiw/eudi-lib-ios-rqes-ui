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

final class TestDocumentSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  var viewModel: DocumentSelectionViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )
    self.viewModel = await DocumentSelectionViewModel(
      router: router,
      interactor: interactor
    )
  }

  override func tearDown() {
    self.interactor = nil
    self.router = nil
    self.config = nil
    self.eudiRQESUi = nil
    self.viewModel = nil
  }

  @MainActor
  func testInitiate_WhenGetSessionReturnSessionData_ThenReturnSuccess() async {
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

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertNil(viewModel.viewState.error)
    XCTAssertEqual(
      viewModel.viewState.documentSelection?.mainText,
      .custom(TestConstants.mockDocumentData.documentName)
    )
  }

  @MainActor
  func testInitiate_WhenGetSessionReturnSessionDataWithNilQtsp_ThenReturnSuccess() async {
    // Given
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertNil(viewModel.viewState.error)
    XCTAssertEqual(
      viewModel.viewState.documentSelection?.mainText,
      .custom(TestConstants.mockDocumentData.documentName)
    )
    XCTAssertEqual(
      viewModel.viewState.qtspServiceSelection?.mainText,
      .selectService
    )
    XCTAssertNil(viewModel.viewState.certificateSelection?.mainText)
  }

  @MainActor
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

  @MainActor
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

  @MainActor
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

  @MainActor
  func testInitiate_WhenGetSessionReturnSessionDataWithNilDocumentName_ThenReturnSuccess() async {
    // Given
    let expectedSession: SessionData = .init()

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(
      viewModel.viewState.error?.title,
      .genericErrorMessage
    )
  }

  @MainActor
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

  @MainActor
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

  @MainActor
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

