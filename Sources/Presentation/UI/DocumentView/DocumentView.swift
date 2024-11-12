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
  @ObservedObject var viewModel: DocumentViewModel<Router>
  @Environment(\.localizationController) var localization

  private let isSigned: Bool

  init(with viewModel:DocumentViewModel<Router>, isSigned: Bool = false) {
    self.viewModel = viewModel
    self.isSigned = isSigned
  }

  var body: some View {
    content(
      navigationTitle: localization.get(with: .viewDocument),
      toolbarContent: isSigned ? toolbarAction() : nil,
      viewState: viewModel.viewState
    )
  }

  private func toolbarAction() -> ToolBarContent {
    ToolBarContent(
      trailingActions: [
        Action(
          image: Image(.verifiedUser)
        )
      ]
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  navigationTitle: String,
  toolbarContent: ToolBarContent?,
  viewState: DocumentState
) -> some View {
  ContentScreenView(
    title: navigationTitle,
    toolbarContent: toolbarContent
  ) {
    if let errorMessage = viewState.errorMessage {
      Text(errorMessage)
        .font(.headline)
        .foregroundColor(.red)
        .padding()
        .eraseToAnyView()

    } else if let document = viewState.pdfDocument {
      PDFViewRepresented(
        pdfDocument: document
      )
    }
  }
}

#Preview {
  let data = Data(base64Encoded: "JVBERi0xLjEKJcKlwrHDqwoKMSAwIG9iagogIDw8IC9UeXBlIC9DYXRhbG9nCiAgICAgL1BhZ2VzIDIgMCBSCiAgPj4KZW5kb2JqCgoyIDAgb2JqCiAgPDwgL1R5cGUgL1BhZ2VzCiAgICAgL0tpZHMgWzMgMCBSXQogICAgIC9Db3VudCAxCiAgICAgL01lZGlhQm94IFswIDAgMzAwIDE0NF0KICA+PgplbmRvYmoKCjMgMCBvYmoKICA8PCAgL1R5cGUgL1BhZ2UKICAgICAgL1BhcmVudCAyIDAgUgogICAgICAvUmVzb3VyY2VzCiAgICAgICA8PCAvRm9udAogICAgICAgICAgIDw8IC9GMQogICAgICAgICAgICAgICA8PCAvVHlwZSAvRm9udAogICAgICAgICAgICAgICAgICAvU3VidHlwZSAvVHlwZTEKICAgICAgICAgICAgICAgICAgL0Jhc2VGb250IC9UaW1lcy1Sb21hbgogICAgICAgICAgICAgICA+PgogICAgICAgICAgID4+CiAgICAgICA+PgogICAgICAvQ29udGVudHMgNCAwIFIKICA+PgplbmRvYmoKCjQgMCBvYmoKICA8PCAvTGVuZ3RoIDU1ID4+CnN0cmVhbQogIEJUCiAgICAvRjEgMTggVGYKICAgIDAgMCBUZAogICAgKEhlbGxvIFdvcmxkKSBUagogIEVUCmVuZHN0cmVhbQplbmRvYmoKCnhyZWYKMCA1CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxOCAwMDAwMCBuIAowMDAwMDAwMDc3IDAwMDAwIG4gCjAwMDAwMDAxNzggMDAwMDAgbiAKMDAwMDAwMDQ1NyAwMDAwMCBuIAp0cmFpbGVyCiAgPDwgIC9Sb290IDEgMCBSCiAgICAgIC9TaXplIDUKICA+PgpzdGFydHhyZWYKNTY1CiUlRU9GCg==")!
  let document = PDFDocument(data: data)

  content(
    navigationTitle: "View document",
    toolbarContent: nil,
    viewState: .init(
      pdfDocument: document,
      errorMessage: nil,
      documentSource: nil
    )
  )
}
