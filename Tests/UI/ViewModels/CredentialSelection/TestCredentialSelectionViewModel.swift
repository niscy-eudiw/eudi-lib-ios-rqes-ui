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

final class TestCredentialSelectionViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  var viewModel: CredentialSelectionViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )
    self.viewModel = await CredentialSelectionViewModel(
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
  func testInitiate_successfulCredentialsFetch_updatesState() async throws {
    // Given
    let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
    let expectedCredentials = [expectedCredentialInfo]

    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenReturn(.success(expectedCredentials))
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertEqual(viewModel.viewState.credentials.count, expectedCredentials.count)
    XCTAssertEqual(viewModel.viewState.credentialInfos.count, expectedCredentials.count)
    XCTAssertNil(viewModel.viewState.error)
  }

  @MainActor
  func testInitiate_WhenFetchCredentialsFailure_ThenSetErrorState() async {
    // Given
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
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)

    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()
    verify(router).pop()
  }

  @MainActor
  func testInitiate_WhenFetchCredentialsReturnsError_ThenSetErrorState() async {
    // Given
    let error = EudiRQESUiError.unableToFetchCredentials
    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenReturn(.failure(error))
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
  }

  @MainActor
  func testSetCertificate_WhenViewStateHasCredentialInfos_ThenSaveCertificateCalled() async throws{
    // Given
    let expectation = XCTestExpectation(description: "saveCertificate called")

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

  @MainActor
  func testNextStep_WhenOpenCredentialAuthrorizationURLFailure_ThenSetErrorState() async {
    // Given
    let expectation = expectation(description: "Error is set in viewState")

    let error = EudiRQESUiError.noDocumentProvided
    stub(interactor) { stub in
      when(stub.openCredentialAuthrorizationURL()).thenThrow(error)
    }

    // When
    viewModel.nextStep()

    Task {
      while viewModel.viewState.error == nil {
        try? await Task.sleep(nanoseconds: 20_000_000)
      }
      expectation.fulfill()
    }

    // Then
    await fulfillment(of: [expectation], timeout: 1.0)

    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)

    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }
    cancelAction()

    XCTAssertNil(viewModel.viewState.error)
  }


  @MainActor
  func testNextStep_WhenOpenCredentialAuthrorizationURLSuccess_ThenOnPauseCalledAndNoError() async {
    // Given
    let url = URL(string: "https://example.com")!

    stub(interactor) { stub in
      when(stub.openCredentialAuthrorizationURL()).thenReturn(url)
    }

    // When
    viewModel.nextStep()
    await Task.yield()

    // Then
    XCTAssertNil(viewModel.viewState.error)
  }

  @MainActor
  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async throws {
    // Given
    let expectation = expectation(description: "State is recovered after retry")
    let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
    let expectedCredentials = [expectedCredentialInfo]

    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenThrow(EudiRQESUiError.unableToFetchCredentials)
    }
    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertNotNil(viewModel.viewState.error)

    stub(interactor) { stub in
      when(stub.fetchCredentials()).thenReturn(.success(expectedCredentials))
    }

    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action should not be nil")
      return
    }
    retryAction()

    Task {
      while viewModel.viewState.error != nil {
        try? await Task.sleep(nanoseconds: 20_000_000)
      }
      expectation.fulfill()
    }
    await fulfillment(of: [expectation], timeout: 1.0)

    XCTAssertNil(viewModel.viewState.error)
    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertEqual(viewModel.viewState.credentials.count, expectedCredentials.count)
    XCTAssertEqual(viewModel.viewState.credentialInfos.count, expectedCredentials.count)
  }
}

