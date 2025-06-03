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

    XCTAssertFalse(viewModel.viewState.isLoading)
    XCTAssertNotNil(viewModel.viewState.error)
    XCTAssertEqual(viewModel.viewState.documentSource, expectedDocumentSource)
    XCTAssertEqual(viewModel.viewState.documentSource, expectedDocumentSource)

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

    XCTAssertEqual(viewModel.viewState.error?.title, .genericErrorMessage)

    cancelAction()
    verify(router).pop()
  }
}
