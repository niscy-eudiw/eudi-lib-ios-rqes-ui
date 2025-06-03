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
import SwiftUI
import PDFKit

enum DocumentSource: Hashable, Equatable {
  case pdfUrl(URL)
}

@Copyable
struct DocumentState: ViewState {
  let isLoading: Bool
  let pdfDocument: PDFDocument?
  let documentSource: DocumentSource?
  let error: ContentErrorView.Config?
}

class DocumentViewModel<Router: RouterGraph>: ViewModel<Router, DocumentState> {
  
  private let interactor: RQESInteractor
  
  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: DocumentState(
        isLoading: true,
        pdfDocument: nil,
        documentSource: nil,
        error: nil
      )
    )
  }
  
  func initiate() async {
    let uri = await interactor.getSession()?.document?.uri
    if let uri {
      let source = DocumentSource.pdfUrl(uri)
      loadDocument(from: source)
    } else {
      setErrorState {
        self.router.pop()
      }
    }
  }
  
  private func loadDocument(from source: DocumentSource) {
    setState {
      $0.copy(
        isLoading: false,
        documentSource: source
      )
    }
    switch source {
    case .pdfUrl(let url):
      loadPDF(
        fromURL: url
      )
    }
  }
  
  private func loadPDF(fromURL url: URL) {
    if let document = PDFDocument(url: url) {
      setState {
        $0.copy(
          isLoading: false,
          pdfDocument: document
        )
        .copy(error: nil)
      }
    } else {
      setErrorState {
        self.router.pop()
      }
    }
  }
  
  private func setErrorState(cancelAction: @escaping () -> ()) {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: .genericErrorDocumentNotFound,
          cancelAction: cancelAction,
          action: { Task { await self.initiate() } }
        )
      )
    }
  }
}
