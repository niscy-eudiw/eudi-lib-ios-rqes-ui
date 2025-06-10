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
final class TestCredentialSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  var viewModel: CredentialSelectionViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.viewModel = CredentialSelectionViewModel(
      router: router,
      interactor: interactor
    )
  }

  override func tearDown() async throws {
    self.interactor = nil
    self.router = nil
    self.viewModel = nil
  }

  func testInitiate_successfulCredentialsFetch_updatesState() async throws {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
    let expectedCredentials = [expectedCredentialInfo]

    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenReturn(.success(expectedCredentials))
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(state.credentials.count, expectedCredentials.count)
    XCTAssertEqual(state.credentialInfos.count, expectedCredentials.count)
    XCTAssertNil(state.error)
  }

  func testInitiate_WhenFetchCredentialsFailure_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let error = EudiRQESUiError.unableToFetchCredentials
    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenThrow(error)
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

    await waitUntil{ self.viewModel.viewState.error != nil }

    let state = stateRecorder.fetchState()
    XCTAssertEqual(state.error?.title, .genericErrorMessage)

    verify(router).pop()
  }

  func testInitiate_WhenFetchCredentialsReturnsError_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let error = EudiRQESUiError.unableToFetchCredentials
    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenReturn(.failure(error))
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertEqual(state.error?.title, .genericErrorMessage)
  }

  func testSetCertificate_WhenViewStateHasCredentialInfos_ThenSaveCertificateCalled() async throws{
    // Given
    let expectation = XCTestExpectation(description: "SaveCertificate called")

    let credentialDataUIModel = CredentialDataUIModel(id: "id", name: "description")
    let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
    let expectedCredentialInfos = [expectedCredentialInfo]

    viewModel.setState {
      $0.copy(
        isLoading: false,
        credentials: expectedCredentialInfos.map { $0.toUi() },
        credentialInfos: expectedCredentialInfos
      )
      .copy(error: nil)
    }

    stub(interactor) { stub in
      when(stub.saveCertificate(any())).then { _ in
        expectation.fulfill()
      }
    }

    // When
    viewModel.setCertificate(credentialDataUIModel)

    // Then
    await fulfillment(of: [expectation], timeout: 1)
    verify(interactor).saveCertificate(any())
  }

  func testNextStep_WhenOpenCredentialAuthrorizationURLFailure_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )

    let error = EudiRQESUiError.noDocumentProvided
    stub(interactor) { stub in
      when(stub.openCredentialAuthrorizationURL()).thenThrow(error)
    }

    // When
    viewModel.nextStep()

    // Then
    await waitUntil{ self.viewModel.viewState.error != nil }

    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("CancelAction should not be nil")
      return
    }
    cancelAction()

    let state = stateRecorder.fetchStates(expectedCount: 2)

    guard let firstState = state.first, let lastState = state.last else {
      XCTFail("Expected error in state, but was nil")
      return
    }
    XCTAssertEqual(firstState.error?.title, .genericErrorMessage)
    XCTAssertNil(lastState.error)
  }

  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async throws {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
    let expectedCredentials = [expectedCredentialInfo]

    stub(interactor) { stub in
      when(stub.fetchCredentials())
        .thenThrow(EudiRQESUiError.unableToFetchCredentials)
        .thenReturn(.success(expectedCredentials))
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

    XCTAssertNil(state.last!.error)
    XCTAssertFalse(lastState.isLoading)
    XCTAssertEqual(lastState.credentials.count, expectedCredentials.count)
    XCTAssertEqual(lastState.credentialInfos.count, expectedCredentials.count)
  }
}

