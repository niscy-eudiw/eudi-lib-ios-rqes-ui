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

final class TestSignedDocumentViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  var viewModel: SignedDocumentViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )
    self.viewModel = await SignedDocumentViewModel(
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

  @MainActor
  func testInitiate_WhenSignDocumentThrowError_ThenSetErrorState() async {
    // Given
    let expectedError = EudiRQESUiError.noDocumentProvided

    stub(interactor) { mock in
      when(mock.signDocument()).thenThrow(expectedError)
    }

    // When
    await viewModel.initiate()

    // Then
    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
    XCTAssertEqual(viewModel.viewState.error?.description, .genericServiceErrorMessage)

    verify(interactor, never()).getSession()
  }

  @MainActor
  func testInitiate_WhenGenSessionThrowError_ThenSetErrorState() async {
    // Given
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
    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
    XCTAssertEqual(viewModel.viewState.error?.description, .genericErrorDocumentNotFound)
  }

  @MainActor
  func testInitiate_WhenGenSessionReturnsEmptyDocument_ThenSetErrorState() async {
    // Given
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
    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)
    XCTAssertEqual(viewModel.viewState.error?.description, .genericErrorDocumentNotFound)
  }

  @MainActor
  func testInitiate_WhenGenSessionReturnsSessionData_ThenSetState() async {
    // Given
    let expectedDocument = Document(
      id: "id",
      fileURL: URL(string: "uri")!
    )

    let expectedDocumentData = DocumentData(
      documentName: "documentName",
      uri: URL(string: "uri")!
    )

    let qtsp = QTSPData(
      name: "name",
      uri: URL(string: "uri")!,
      scaURL: "scaURL",
      clientId: "clientId",
      clientSecret: "clientSecret",
      authFlowRedirectionURI: "authFlowRedirectionURI",
      hashAlgorithm: "hashAlgorithm"
    )
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
    XCTAssertEqual(viewModel.viewState.documentName, mockSession.document?.documentName)
    XCTAssertEqual(viewModel.viewState.qtspName, mockSession.qtsp?.name)
    XCTAssertTrue(viewModel.viewState.isInitialized)
  }
}
