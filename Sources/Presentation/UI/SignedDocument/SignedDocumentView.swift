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

struct SignedDocumentView<Router: RouterGraph>: View {
  
  @ObservedObject var viewModel: SignedDocumentViewModel<Router>
  @Environment(\.localizationController) var localization
  
  @State private var showSheet = false

  init(with viewModel: SignedDocumentViewModel<Router>) {
    self.viewModel = viewModel
  }

  var body: some View {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: localization.get(with: .documentSigned),
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: ToolBarContent(
        trailingActions: [
          Action(
            title: localization.get(with: .save),
            callback: {
              showSheet = true
            }
          )
        ]
      )
    ) {
      content(
        success: localization.get(with: .success),
        successfullySigned: localization.get(with: .successfullySignedDocument),
        documentName: viewModel.viewState.documentName,
        signedBy: localization.get(with: .signedBy, args: [viewModel.viewState.qtspName]),
        viewString: localization.get(with: .view),
        isLoading: viewModel.viewState.isLoading,
        view: viewModel.viewDocument
      )
    }
    .confirmationDialog(
      localization.get(with: .sharingDocument),
      isPresented: $showSheet,
      titleVisibility: .visible
    ) {
      Button(localization.get(with: .close), role: .destructive) {
        viewModel.onCancel()
      }

      if let url = viewModel.pdfURL {
        ShareLink(item: url) {
          Label(localization.get(with: .share), systemImage: "swift")
        }
      }
    } message: {
      Text(localization.get(with: .closeSharingDocument))
    }
  }
}

@MainActor
@ViewBuilder
private func content(
  success: String,
  successfullySigned: String,
  documentName: String,
  signedBy: String,
  viewString: String,
  isLoading: Bool,
  view: @escaping () -> Void
) -> some View {
  VStack(alignment: .leading, spacing: SPACING_NONE) {
    Text(success)
      .font(Theme.shared.font.headlineMedium.font)
      .fontWeight(.bold)
      .foregroundStyle(Theme.shared.color.success)
      .padding(.top, SPACING_LARGE_MEDIUM)

    VStack(alignment: .leading, spacing: SPACING_NONE) {
      Text(successfullySigned)
        .font(Theme.shared.font.bodyLarge.font)
        .foregroundStyle(Theme.shared.color.onSurface)

      Text(documentName)
        .font(Theme.shared.font.bodyLarge.font)
        .foregroundStyle(Theme.shared.color.onSurface)
        .fontWeight(.semibold)
    }
    .gone(if: isLoading)
    .padding(.top, SPACING_SMALL)

    CardView(
      type: .success,
      title: documentName,
      subtitle: signedBy,
      trailingView: {
        Text(viewString)
          .font(Theme.shared.font.bodyLarge.font)
      },
      action: { view() },
      trailingAction: { view() }
    )
    .padding(.top, SPACING_MEDIUM)

    Spacer()
  }
}

#Preview {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "Navigation title"
  ) {
    content(
      success: "Success",
      successfullySigned: "You successfully signed your document",
      documentName: "Document title",
      signedBy: "Signed by: Entrust",
      viewString: "View",
      isLoading: false,
      view: {}
    )
  }
}

#Preview("Dark Mode") {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "Navigation title"
  ) {
    content(
      success: "Success",
      successfullySigned: "You successfully signed your document",
      documentName: "Document title",
      signedBy: "Signed by: Entrust",
      viewString: "View",
      isLoading: false,
      view: {}
    )
  }
  .darkModePreview()
}
