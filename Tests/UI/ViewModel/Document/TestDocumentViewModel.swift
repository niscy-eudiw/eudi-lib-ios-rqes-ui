/*
 * Copyright (c) 2026 European Commission
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
import PDFKit
import RqesKit
import RQESLib
@testable import EudiRQESUi

@MainActor
final class TestDocumentViewModel: XCTestCase {
  var interactor: MockRQESInteractor!
  var router: MockRouterGraph!
  var viewModel: DocumentViewModel<MockRouterGraph>!

  override func setUp() async throws {
    self.interactor = MockRQESInteractor()
    self.router = MockRouterGraph()
    self.viewModel = DocumentViewModel(
      router: router,
      interactor: interactor
    )
  }

  override func tearDown() async throws {
    self.interactor = nil
    self.router = nil
    self.viewModel = nil
  }

  func testInitiate_WhenGetSessionDocumentPdfUrl_ThenLoadDocumentFails() async {
    // Given
    let expectedDocumentSource = DocumentSource.pdfUrl(URL(string: "file://internal/test.pdf")!)
    let expectedSession: SessionData = .init(
      document: TestConstants.mockDocumentData
    )

    stub(router) { mock in
      when(mock.pop()).thenDoNothing()
    }

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
    }

    // When
    await viewModel.initiate()

    // Then
    guard let cancelAction = viewModel.viewState.error?.cancelAction else {
      XCTFail("cancelAction should not be nil")
      return
    }

    let state = viewModel.viewState
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(state.documentSource, expectedDocumentSource)

    cancelAction()
    verify(router).pop()
  }

  func testInitiate_WhenGetSessionDocumentisNil_ThenSetErrorState() async {
    // Given
    let expectedSession: SessionData = .init()

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(expectedSession)
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

    let state = viewModel.viewState
    XCTAssertEqual(state.error?.title, .genericErrorMessage)

    cancelAction()
    verify(router).pop()
  }

  func testInitiate_WhenURLPointsToValidPDF_ThenStateContainsPDFDocument() async throws {
    // Given - write a minimal valid PDF to a temp URL
    let pdf = PDFDocument()
    pdf.insert(PDFPage(), at: 0)
    let pdfData = try XCTUnwrap(pdf.dataRepresentation())
    let tempURL = FileManager.default.temporaryDirectory
      .appendingPathComponent("rqes_test_\(UUID().uuidString).pdf")
    try pdfData.write(to: tempURL)
    defer { try? FileManager.default.removeItem(at: tempURL) }

    let session = SessionData(
      document: DocumentData(documentName: tempURL.lastPathComponent, uri: tempURL)
    )

    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(session)
    }

    // When
    await viewModel.initiate()

    // Then
    let state = viewModel.viewState
    XCTAssertFalse(state.isLoading)
    XCTAssertNotNil(state.pdfDocument)
    XCTAssertNil(state.error)
    XCTAssertEqual(state.documentSource, .pdfUrl(tempURL))
  }

  func testErrorAction_WhenInvoked_RetriesInitiateAndRecoversState() async throws {
    // Given - write a minimal valid PDF so the retry can succeed
    let pdf = PDFDocument()
    pdf.insert(PDFPage(), at: 0)
    let pdfData = try XCTUnwrap(pdf.dataRepresentation())
    let tempURL = FileManager.default.temporaryDirectory
      .appendingPathComponent("rqes_test_\(UUID().uuidString).pdf")
    try pdfData.write(to: tempURL)
    defer { try? FileManager.default.removeItem(at: tempURL) }

    let validSession = SessionData(
      document: DocumentData(documentName: tempURL.lastPathComponent, uri: tempURL)
    )

    // First call -> no document (error state); retry -> valid PDF (recovers)
    stub(interactor) { stub in
      when(stub.getSession()).thenReturn(SessionData(), validSession)
    }

    // When - initiate fails into the error state
    await viewModel.initiate()

    guard let retryAction = viewModel.viewState.error?.action else {
      XCTFail("Retry action should not be nil")
      return
    }

    // When - the retry action re-runs initiate and clears the error
    retryAction()
    await waitUntil { self.viewModel.viewState.error == nil }

    // Then
    let state = viewModel.viewState
    XCTAssertNil(state.error)
    XCTAssertFalse(state.isLoading)
    XCTAssertNotNil(state.pdfDocument)
  }
}
