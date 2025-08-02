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
      title: .dataShared,
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: ToolBarContent(
        trailingActions: [
          Action(
            title: .doneButton,
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
      Button(localization.get(with: .doneButton), role: .destructive) {
        viewModel.onCancel()
      }

      if let url = viewModel.pdfURL {
        ShareLink(item: url) {
          Text(localization.get(with: .share))
        }
      }
    } message: {
      Text(localization.get(with: .closeSharingDocument))
    }
    .task {
      await viewModel.initiate()
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
  VStack(alignment: .leading, spacing: SPACING_MEDIUM) {

    ContentHeader(
      config: ContentHeaderConfig(
        appIconAndTextData: AppIconAndTextData(
          appIcon: Image(.euWalletLogo),
          appText: Image(.eudiTextLogo)
        ),
        description: successfullySigned,
        relyingPartyData: RelyingPartyData(
          isVerified: true,
          name: signedBy
        )
      )
    )

    CardView(
      type: .success,
      title: documentName,
      leadingIcon: Image(.gpdGood),
      action: { view() }
    )
    .padding(.top, SPACING_MEDIUM)

    Spacer()
  }
  .gone(if: isLoading)
}

#Preview {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: .custom("Navigation title")
  ) {
    content(
      success: "Success",
      successfullySigned: "You successfully signed your document",
      documentName: "Document title",
      signedBy: "ENTRUST",
      viewString: "View",
      isLoading: false,
      view: {}
    )
  }
  .environment(\.localizationController, PreviewLocalizationController())
}

#Preview("Dark Mode") {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: .custom("Navigation title")
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
  .environment(\.localizationController, PreviewLocalizationController())
}
