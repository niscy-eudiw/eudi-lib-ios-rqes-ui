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

final class TestServiceSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  var viewModel: ServiceSelectionViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )
    self.viewModel = await ServiceSelectionViewModel(
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
  func testInitiate_WhenGetQtspServices_ThenSetState() async {
    // Given
    let qtsp = QTSPData(
      name: "name",
      uri: URL(string: "uri")!,
      scaURL: "scaURL",
      clientId: "clientId",
      clientSecret: "clientSecret",
      authFlowRedirectionURI: "authFlowRedirectionURI",
      hashAlgorithm: "hashAlgorithm"
    )
    let qtspData = [qtsp]

    stub(interactor) { stub in
      when(stub.getQTSps()).thenReturn(qtspData)
    }

    // When
    await viewModel.initiate()

    // Then

    XCTAssertNil(viewModel.viewState.error)
    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertEqual(viewModel.viewState.services, qtspData)
  }

  @MainActor
  func testInitiate_WhenGetQtspServicesIsEmpty_ThenSetErrorState() async {
    // Given
    stub(interactor) { stub in
      when(stub.getQTSps()).thenReturn([])
    }

    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()

    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
    verify(router).pop()
  }

  @MainActor
  func testOpenAuthorization_WhenCreateRQESServiceFails_ThenSetErrorState() async {
    // Given
    let expectation = self.expectation(description: "Error is set in viewState")

    let expectedError = EudiRQESUiError.noDocumentProvided
    let qtsp = QTSPData(
      name: "name",
      uri: URL(string: "uri")!,
      scaURL: "scaURL",
      clientId: "clientId",
      clientSecret: "clientSecret",
      authFlowRedirectionURI: "authFlowRedirectionURI",
      hashAlgorithm: "hashAlgorithm"
    )
    viewModel.selectedItem = qtsp

    stub(interactor) { stub in
      when(stub.createRQESService(any())).thenThrow(expectedError)
    }

    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    viewModel.nextStep()

    Task {
      while viewModel.viewState.error == nil {
        try? await Task.sleep(nanoseconds: 20_000_000)
      }
      expectation.fulfill()
    }

    await fulfillment(of: [expectation], timeout: 1.0)

    // Then
    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)

    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()
    verify(router).pop()
  }

  @MainActor
  func testOpenAuthorization_WhenAllSucceeds_ThenNoErrorAndPauseCalled() async {
    // Given
    let expectation = self.expectation(description: "All interactor methods called")

    let qtsp = QTSPData(
      name: "name",
      uri: URL(string: "uri")!,
      scaURL: "scaURL",
      clientId: "clientId",
      clientSecret: "clientSecret",
      authFlowRedirectionURI: "authFlowRedirectionURI",
      hashAlgorithm: "hashAlgorithm"
    )

    viewModel.selectedItem = qtsp

    let expectedURL = URL(string: "https://test")!

    stub(interactor) { stub in
      when(stub.createRQESService(equal(to: qtsp))).thenDoNothing()
      when(stub.openAuthrorizationURL()).thenReturn(expectedURL)
      when(stub.updateQTSP(equal(to: qtsp))).thenDoNothing()
    }

    // When
    viewModel.nextStep()

    Task {
      while viewModel.viewState.error == nil {
        try? await Task.sleep(nanoseconds: 20_000_000)
      }
      expectation.fulfill()
    }

    await fulfillment(of: [expectation], timeout: 1.0)

    // Then
    XCTAssertFalse(viewModel.viewState.isLoading)

    verify(interactor).createRQESService(equal(to: qtsp))
    verify(interactor).openAuthrorizationURL()
    verify(interactor).updateQTSP(equal(to: qtsp))
  }

  @MainActor
  func testOpenAuthorization_WhenSelectedItemIsNil_ThenThrowError() async {
    // Given
    viewModel.selectedItem = nil

    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    viewModel.openAuthorization()

    // Then
    let expectation = self.expectation(description: "Error is set in viewState")
    Task {
      while viewModel.viewState.error == nil {
        try? await Task.sleep(nanoseconds: 20_000_000)
      }
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1.0)

    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()

    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)

    verify(router).pop()

    verify(interactor, never()).createRQESService(any())
    verify(interactor, never()).openAuthrorizationURL()
    verify(interactor, never()).updateQTSP(any())
  }

  @MainActor
  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async {
    stub(interactor) { stub in
      when(stub.getQTSps()).thenReturn([])
    }
    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }
    await viewModel.initiate()
    XCTAssertNotNil(viewModel.viewState.error)

    let qtsp = QTSPData(
      name: "name",
      uri: URL(string: "uri")!,
      scaURL: "scaURL",
      clientId: "clientId",
      clientSecret: "clientSecret",
      authFlowRedirectionURI: "authFlowRedirectionURI",
      hashAlgorithm: "hashAlgorithm"
    )
    let qtspData = [qtsp]
    stub(interactor) { stub in
      when(stub.getQTSps()).thenReturn(qtspData)
    }

    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action should not be nil")
      return
    }
    retryAction()

    let expectation = expectation(description: "State is recovered after retry")
    Task {
      while viewModel.viewState.error != nil {
        try? await Task.sleep(nanoseconds: 20_000_000)
      }
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1.0)

    XCTAssertNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.services, qtspData)
    XCTAssertFalse(viewModel.viewState.isLoading)
  }
}
