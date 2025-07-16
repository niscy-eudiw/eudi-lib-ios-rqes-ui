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
final class TestServiceSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  var viewModel: ServiceSelectionViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.viewModel = ServiceSelectionViewModel(
      router: router,
      interactor: interactor
    )
  }

  override func tearDown() async throws {
    self.interactor = nil
    self.router = nil
    self.viewModel = nil
  }

  func testInitiate_WhenGetQtspServices_ThenSetState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let qtsp = TestConstants.mockQtspData
    let qtspData = [qtsp]

    stub(interactor) { stub in
      when(stub.getQTSps()).thenReturn(qtspData)
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertNil(state.error)
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(state.services, qtspData)
  }

  func testInitiate_WhenGetQtspServicesIsEmpty_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
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

    let state = stateRecorder.fetchState()
    XCTAssertNotNil(state.error)
    XCTAssertEqual(state.error?.title, .genericErrorMessage)
    verify(router).pop()
  }

  func testOpenAuthorization_WhenCreateRQESServiceFails_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedError = EudiRQESUiError.noDocumentProvided
    let qtsp = TestConstants.mockQtspData
    viewModel.selectedItem = qtsp

    stub(interactor) { stub in
      when(stub.createRQESService(any())).thenThrow(expectedError)
    }

    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    viewModel.nextStep()

    await waitUntil{ self.viewModel.viewState.error != nil }

    // Then
    let state = stateRecorder.fetchStates(expectedCount: 2)
    guard let firstState = state.first, let lastState = state.last else {
      XCTFail("Expected error in state, but was nil")
      return
    }
    XCTAssertNil(firstState.error)
    XCTAssertNotNil(lastState.error)
    XCTAssertEqual(lastState.error?.title, .genericErrorMessage)

    guard let cancelAction = state.last!.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()
    verify(router).pop()
  }

  func testOpenAuthorization_WhenAllSucceeds_ThenNoErrorAndPauseCalled() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )

    let qtsp = TestConstants.mockQtspData

    viewModel.selectedItem = qtsp

    let expectedURL = URL(string: "https://test")!

    stub(interactor) { stub in
      when(stub.createRQESService(equal(to: qtsp))).thenDoNothing()
      when(stub.openAuthrorizationURL()).thenReturn(expectedURL)
      when(stub.updateQTSP(equal(to: qtsp))).thenDoNothing()
    }

    // When
    viewModel.nextStep()

    await waitUntil{ self.viewModel.viewState.error != nil }

    // Then
    let state = stateRecorder.fetchStates(expectedCount: 2)
    guard let lastState = state.last else {
      XCTFail("Expected error in state, but was nil")
      return
    }

    XCTAssertFalse(lastState.isLoading)

    verify(interactor).createRQESService(equal(to: qtsp))
    verify(interactor).openAuthrorizationURL()
    verify(interactor).updateQTSP(equal(to: qtsp))
  }

  func testOpenAuthorization_WhenSelectedItemIsNil_ThenThrowError() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    viewModel.selectedItem = nil

    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    viewModel.nextStep()

    // Then
    await waitUntil{ self.viewModel.viewState.error != nil }

    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()

    let state = stateRecorder.fetchStates(expectedCount: 2)
    guard let lastState = state.last else {
      XCTFail("Expected error in state, but was nil")
      return
    }
    XCTAssertNotNil(lastState.error)
    XCTAssertEqual(lastState.error?.title, .genericErrorMessage)

    verify(router).pop()

    verify(interactor, never()).createRQESService(any())
    verify(interactor, never()).openAuthrorizationURL()
    verify(interactor, never()).updateQTSP(any())
  }

  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let qtsp = TestConstants.mockQtspData
    let qtspData = [qtsp]

    stub(interactor) { stub in
      when(stub.getQTSps()).thenReturn([], qtspData)
    }
    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action should not be nil")
      return
    }
    retryAction()

    await waitUntil{ self.viewModel.viewState.error == nil }

    let state = stateRecorder.fetchStates(expectedCount: 2)
    guard let firstState = state.first, let lastState = state.last else {
      XCTFail("Expected error in state, but was nil")
      return
    }

    XCTAssertNotNil(firstState.error)

    XCTAssertNil(lastState.error)
    XCTAssertEqual(lastState.services, qtspData)
    XCTAssertFalse(lastState.isLoading)
  }
}
