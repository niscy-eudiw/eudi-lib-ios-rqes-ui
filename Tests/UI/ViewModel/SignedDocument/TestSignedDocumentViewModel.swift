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
import RQESLib
@testable import EudiRQESUi

@MainActor
final class TestSignedDocumentViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var viewModel: SignedDocumentViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.viewModel = SignedDocumentViewModel(
      router: router,
      interactor: interactor
    )
  }

  override func tearDown() async throws {
    self.interactor = nil
    self.router = nil
    self.viewModel = nil
  }

  func testViewDocument_ThenNavigatesToViewDocumentWith() async {
    // Given
    stub(router) { mock in
      when(mock.navigateTo(any())).thenDoNothing()
    }

    // When
    viewModel.viewDocument()

    // Then
    verify(router).navigateTo(equal(to: .viewDocument(true)))
  }

  func testInitiate_WhenSignDocumentThrowError_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedError = EudiRQESUiError.noDocumentProvided

    stub(interactor) { mock in
      when(mock.signDocument()).thenThrow(expectedError)
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertNotNil(state.error)
    XCTAssertEqual(state.error?.title, .genericErrorMessage)
    XCTAssertEqual(state.error?.description, .genericServiceErrorMessage)

    verify(interactor, never()).getSession()
  }

  func testInitiate_WhenGetSessionReturnNil_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedDocument = Document(
      id: "id",
      fileURL: URL(string: "uri")!
    )

    stub(interactor) { mock in
      when(mock.signDocument()).thenReturn(expectedDocument)
    }

    stub(interactor) { mock in
      when(mock.getSession()).thenReturn(nil)
    }

    stub(interactor) { mock in
      when(mock.updateDocument(any())).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertNotNil(state.error)
    XCTAssertEqual(state.error?.title, .genericErrorMessage)
    XCTAssertEqual(state.error?.description, .genericErrorDocumentNotFound)
  }

  func testInitiate_WhenGenSessionReturnsEmptyDocument_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let mockSession : SessionData = .init()
    let expectedDocument = Document(
      id: "id",
      fileURL: URL(string: "uri")!
    )

    stub(interactor) { mock in
      when(mock.signDocument()).thenReturn(expectedDocument)
    }

    stub(interactor) { mock in
      when(mock.getSession()).thenReturn(mockSession)
    }

    stub(interactor) { mock in
      when(mock.updateDocument(any())).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertNotNil(state.error)
    XCTAssertEqual(state.error?.title, .genericErrorMessage)
    XCTAssertEqual(state.error?.description, .genericErrorDocumentNotFound)
  }

  func testInitiate_WhenGenSessionReturnsSessionData_ThenSetState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedDocument = Document(
      id: "id",
      fileURL: URL(string: "uri")!
    )

    let expectedDocumentData = DocumentData(
      documentName: "documentName",
      uri: URL(string: "uri")!
    )

    let qtsp = TestConstants.mockQtspData
    let mockSession: SessionData = .init(
      document: expectedDocumentData,
      qtsp: qtsp
    )

    stub(interactor) { mock in
      when(mock.signDocument()).thenReturn(expectedDocument)
    }

    stub(interactor) { mock in
      when(mock.getSession()).thenReturn(mockSession)
    }

    stub(interactor) { mock in
      when(mock.updateDocument(any())).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertEqual(state.documentName, mockSession.document?.documentName)
    XCTAssertEqual(state.qtspName, mockSession.qtsp?.name)
    XCTAssertEqual(
      state.headerConfig.appIconAndTextData.appIcon,
      Image(.euWalletLogo)
    )
    XCTAssertEqual(
      state.headerConfig.appIconAndTextData.appText,
      Image(.eudiTextLogo)
    )
    XCTAssertTrue(state.isInitialized)
  }

  func testErrorAction_WhenInvoked_RetriesAndRecoversState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let expectedDocument = Document(
      id: "id",
      fileURL: URL(string: "uri")!
    )
    let expectedDocumentData = DocumentData(
      documentName: "documentName",
      uri: URL(string: "uri")!
    )
    let qtsp = TestConstants.mockQtspData
    let mockSession: SessionData = .init(
      document: expectedDocumentData,
      qtsp: qtsp
    )

    stub(interactor) { mock in
      when(mock.signDocument())
        .thenThrow(EudiRQESUiError.noDocumentProvided)
        .thenReturn(expectedDocument)
    }

    stub(interactor) { mock in
      when(mock.getSession()).thenReturn(mockSession)
    }
    stub(interactor) { mock in
      when(mock.updateDocument(any())).thenDoNothing()
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
    XCTAssertEqual(firstState.error?.title, .genericErrorMessage)

    XCTAssertNil(lastState.error)
    XCTAssertFalse(lastState.isLoading)
    XCTAssertEqual(lastState.documentName, expectedDocumentData.documentName)
    XCTAssertEqual(lastState.qtspName, qtsp.name)
    XCTAssertTrue(lastState.isInitialized)
    XCTAssertEqual(
      lastState.headerConfig.appIconAndTextData.appIcon,
      Image(.euWalletLogo)
    )
    XCTAssertEqual(
      lastState.headerConfig.appIconAndTextData.appText,
      Image(.eudiTextLogo)
    )
  }

  func testInitiate_WhenIsInitializedIsTrue_ThenDoesNothing() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
    let initialState = SignedDocumenState(
      isLoading: false,
      document: DocumentData(
        documentName: "test.pdf",
        uri: URL(string: "file://uri")!
      ),
      qtsp: TestConstants.mockQtspData,
      documentName: "test.pdf",
      qtspName: "qtsp",
      headerConfig: .init(
        appIconAndTextData: .init(
          appIcon: Image(.euWalletLogo),
          appText: Image(.eudiTextLogo)
        )
      ),
      error: nil,
      isInitialized: true
    )

    viewModel.setState { _ in initialState }

    stub(interactor) { mock in
      when(mock.signDocument()).thenReturn(nil)

      when(mock.getSession()).thenReturn(nil)

      when(mock.updateDocument(any())).thenDoNothing()
    }

    // When
    await viewModel.initiate()

    // Then
    let state = stateRecorder.fetchState()
    XCTAssertTrue(state.isInitialized)
  }
}
