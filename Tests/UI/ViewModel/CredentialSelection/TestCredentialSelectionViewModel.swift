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
final class TestCredentialSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
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
  let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
  let expectedCredentials = [expectedCredentialInfo]

  stub(interactor) { stub in
    when(stub.fetchCredentials()).thenReturn(.success(expectedCredentials))
  }

  let exp = beginObservation {
    _ = self.viewModel.viewState
  }

  // When
  await viewModel.initiate()

  // Then
  let state = viewModel.viewState
  await fulfillment(of: [exp], timeout: 1.0)

  XCTAssertFalse(state.isLoading)
  XCTAssertEqual(state.credentials.count, expectedCredentials.count)
  XCTAssertEqual(state.credentialInfos.count, expectedCredentials.count)
  XCTAssertNil(state.error)
}

func testInitiate_WhenFetchCredentialsFailure_ThenSetErrorState() async {
  // Given
  let error = EudiRQESUiError.unableToFetchCredentials
  stub(interactor) { stub in
    when(stub.fetchCredentials()).thenThrow(error)
  }

  stub(router) { mock in
    when(mock.pop()).thenDoNothing()
  }

  let exp = beginObservation {
    _ = self.viewModel.viewState
  }

  // When
  await viewModel.initiate()

  await fulfillment(of: [exp], timeout: 1.0)
  // Then
  guard let cancelAction = viewModel.viewState.error?.cancelAction else {
    XCTFail("cancelAction should not be nil")
    return
  }
  cancelAction()

  let state = viewModel.viewState
  XCTAssertEqual(state.error?.title, .genericErrorMessage)

  verify(router).pop()
}

func testInitiate_WhenFetchCredentialsReturnsError_ThenSetErrorState() async {
  // Given
  let error = EudiRQESUiError.unableToFetchCredentials
  stub(interactor) { stub in
    when(stub.fetchCredentials()).thenReturn(.failure(error))
  }

  let exp = beginObservation {
    _ = self.viewModel.viewState
  }

  // When
  await viewModel.initiate()

  await fulfillment(of: [exp], timeout: 1.0)

  // Then
  XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
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

  func testNextStep_WhenOpenCredentialAuthrorizationURLFailureWithCancelAction_ThenSetErrorState() async {
    // Given
    let config = MockEudiRQESUiConfig()
    stub(config) { mock in
      when(mock.theme.get).thenReturn(AppTheme())
    }
    
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )

    let error = EudiRQESUiError.noDocumentProvided
    stub(interactor) { stub in
      when(stub.openCredentialAuthrorizationURL()).thenThrow(error)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
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

    await fulfillment(of: [exp], timeout: 1)
    
    XCTAssertNil(viewModel.viewState.error)
  }

  func testNextStep_WhenOpenCredentialAuthrorizationURLFailure_ThenSetErrorState() async {
    // Given
    let config = MockEudiRQESUiConfig()
    stub(config) { mock in
      when(mock.theme.get).thenReturn(AppTheme())
    }

    self.eudiRQESUi = .init(
      config: config,
      router: router
    )

    let error = EudiRQESUiError.noDocumentProvided
    stub(interactor) { stub in
      when(stub.openCredentialAuthrorizationURL()).thenThrow(error)
    }

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    viewModel.nextStep()

    // Then
    await fulfillment(of: [exp], timeout: 1)

    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
  }

  func testErrorAction_WhenInvokedWithRetryAction_RetriesAndRecoversState() async throws {
    // Given
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

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    await viewModel.initiate()

    // Then
    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action should not be nil")
      return
    }
    retryAction()

    await fulfillment(of: [exp], timeout: 1)

    let state = viewModel.viewState
    XCTAssertNil(state.error)
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(state.credentials.count, expectedCredentials.count)
    XCTAssertEqual(state.credentialInfos.count, expectedCredentials.count)
  }

  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async throws {
    // Given
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

    let exp = beginObservation {
      _ = self.viewModel.viewState
    }

    // When
    await viewModel.initiate()

    // Then
    guard let error = viewModel.viewState.error else {
      XCTFail("error should not be nil")
      return
    }

    await fulfillment(of: [exp], timeout: 1)

    XCTAssertNotNil(error)
    XCTAssertEqual(error.title, .genericErrorMessage)
  }
}
