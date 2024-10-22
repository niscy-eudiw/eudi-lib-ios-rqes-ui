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

private struct PDFViewRepresented: UIViewRepresentable {
  let pdfDocument: PDFDocument?
  
  func makeUIView(context: Context) -> PDFView {
    let pdfView = PDFView()
    pdfView.autoScales = true
    
    if let document = pdfDocument {
      pdfView.document = document
    }
    
    return pdfView
  }
  
  func updateUIView(_ uiView: PDFView, context: Context) {
    if let document = pdfDocument {
      uiView.document = document
    }
  }
}

struct DocumentViewer<Router: RouterGraph>: View {
  @StateObject var viewModel: DocumentViewModel<Router>
  
  init(
    router: Router,
    source: DocumentSource
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        router: router,
        initialState: .init(
          pdfDocument: nil,
          errorMessage: nil,
          documentSource: source
        )
      )
    )
  }
  
  var body: some View {
    if let errorMessage = viewModel.viewState.errorMessage {
      Text(errorMessage)
        .font(.headline)
        .foregroundColor(.red)
        .padding()
    } else if let documentType = viewModel.viewState.documentSource {
      switch documentType {
      case .pdfUrl, .pdfBase64:
        if let pdfDocument = viewModel.viewState.pdfDocument {
          PDFViewRepresented(pdfDocument: pdfDocument)
            .edgesIgnoringSafeArea(.all) // Fullscreen PDF
        } else {
          ProgressView("Loading PDF...")
            .font(.headline)
        }
      }
    } else {
      ProgressView("Loading document...")
        .font(.headline)
    }
  }
}

