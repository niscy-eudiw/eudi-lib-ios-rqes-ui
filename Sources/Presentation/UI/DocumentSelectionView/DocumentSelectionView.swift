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

struct DocumentSelectionView<Router: RouterGraph>: View {
  
  @Environment(\.localizationController) var localization
  @ObservedObject var viewModel: DocumentSelectionViewModel<Router>

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
    .task {
      await viewModel.initiate()
    }
    .confirmationDialog(
      title: .cancelSigningProcessTitle,
      message: .cancelSigningProcessSubtitle,
      destructiveText: .cancelSigning,
      baseText: .continueSigning,
      isPresented: $showSheet,
      destructiveAction: {
        viewModel.onCancel()
      },
      baseAction: {
        showSheet.toggle()
      }
    )
    .eraseToAnyView()
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
        leadingIconTint: Theme.shared.color.success,
        action: {}
      ),
      qtspServiceSelection: SelectionItemData(
        mainText: .selectCertificate,
        subtitle: .signingCertificateDescription,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: Theme.shared.color.onSurface,
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
        leadingIconTint: Theme.shared.color.success,
        action: {}
      ),
      qtspServiceSelection: SelectionItemData(
        mainText: .selectCertificate,
        subtitle: .signingCertificateDescription,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: Theme.shared.color.onSurface,
        action: {}
      ),
      certificateSelection: nil
    )
  }
  .darkModePreview()
  .environment(\.localizationController, PreviewLocalizationController())
}
