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
    let stateRecorder = viewModel.$viewState.record()
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

    let state = stateRecorder.fetchState()
    XCTAssertFalse(state.isLoading)
    XCTAssertNil(state.error)
    XCTAssertEqual(state.documentSource, expectedDocumentSource)
    XCTAssertEqual(state.documentSource, expectedDocumentSource)

    cancelAction()
    verify(router).pop()
  }

  func testInitiate_WhenGetSessionDocumentisNil_ThenSetErrorState() async {
    // Given
    let stateRecorder = viewModel.$viewState.record()
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

    let state = stateRecorder.fetchState()
    XCTAssertEqual(state.error?.title, .genericErrorMessage)

    cancelAction()
    verify(router).pop()
  }
}
