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

struct DocumentSelectionView<Router: RouterGraph>: View {
  
  @Environment(\.localizationController) var localization
  @State var viewModel: DocumentSelectionViewModel<Router>

  @State private var showSheet = false

  init(with viewModel:DocumentSelectionViewModel<Router>) {
    self.viewModel = viewModel
  }

  var body: some View {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: .signDocument,
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: .init(
        leadingActions: [
          Action(
            title: .cancel,
            callback: { showSheet.toggle() }
          )
        ]
      )
    ) {
      content(
        documentSelection: viewModel.viewState.documentSelection,
        qtspServiceSelection: viewModel.viewState.qtspServiceSelection,
        certificateSelection: viewModel.viewState.certificateSelection
      )
    }
    .dialogCompat(
      localization.get(with: .cancelSigningProcessTitle),
      isPresented: $showSheet,
      actions: {
        Button(localization.get(with: .continueSigning), role: .cancel) {
          showSheet.toggle()
        }
        Button(localization.get(with: .cancelSigning), role: .destructive) {
          viewModel.onCancel()
        }
      },
      message: {
        Text(localization.get(with: .cancelSigningProcessSubtitle))
      }
    )
    .task {
      await viewModel.initiate()
    }
  }
}

@MainActor
@ViewBuilder
private func content(
  documentSelection: SelectionItemData?,
  qtspServiceSelection: SelectionItemData?,
  certificateSelection: SelectionItemData?
) -> some View {

  ScrollView {
    VStack(alignment: .leading,spacing: SPACING_MEDIUM) {
      if let documentSelection {
        SelectionItemView(
          selectionItemData: documentSelection
        )

        Divider()
      }

      if let qtspServiceSelection {
        SelectionItemView(
          selectionItemData: qtspServiceSelection
        )
      }

      if let certificateSelection {
        Divider()

        SelectionItemView(
          selectionItemData: certificateSelection
        )
      }
    }
  }
  .scrollIndicators(.hidden)
}

#Preview {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: .custom("title")
  ) {
    content(
      documentSelection: SelectionItemData(
        overlineText: .selectDocument,
        mainText: .custom("documentName"),
        subtitle: .selectDocumentFromDevice,
        actionText: .view,
        leadingIcon: Image(.stepOne),
        leadingIconTint: EudiRQESUi.requireTheme().color.success,
        action: {}
      ),
      qtspServiceSelection: SelectionItemData(
        mainText: .selectCertificate,
        subtitle: .signingCertificateDescription,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: EudiRQESUi.requireTheme().color.onSurface,
        action: {}
      ),
      certificateSelection: nil
    )
  }
  .environment(\.localizationController, PreviewLocalizationController())
}

#Preview("Dark Mode") {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: .custom("title")
  ) {
    content(
      documentSelection: SelectionItemData(
        overlineText: .selectDocument,
        mainText: .custom("documentName"),
        subtitle: .selectDocumentFromDevice,
        actionText: .view,
        leadingIcon: Image(.stepOne),
        leadingIconTint: EudiRQESUi.requireTheme().color.success,
        action: {}
      ),
      qtspServiceSelection: SelectionItemData(
        mainText: .selectCertificate,
        subtitle: .signingCertificateDescription,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: EudiRQESUi.requireTheme().color.onSurface,
        action: {}
      ),
      certificateSelection: nil
    )
  }
  .darkModePreview()
  .environment(\.localizationController, PreviewLocalizationController())
}
