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
      title: localization.get(with: .confirmSelection),
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: .init(
        trailingActions: [
          Action(
            title: localization.get(with: .proceed),
            callback: {
              viewModel.selectService()
            }
          )
        ],
        leadingActions: [
          Action(
            title: localization.get(with: .cancel),
            callback: { showSheet.toggle() }
          )
        ]
      )
    ) {
      content(
        confirmSelectionTitle: localization.get(with: .confirmSelectionTitle),
        documentName: viewModel.viewState.documentName,
        viewString: localization.get(with: .view),
        view: viewModel.viewDocument
      )
    }
    .task {
      await viewModel.initiate()
    }
    .confirmationDialog(
      title: localization.get(with: .cancelSigningProcessTitle),
      message: localization.get(with: .cancelSigningProcessSubtitle),
      destructiveText: localization.get(with: .cancelSigning),
      baseText: localization.get(with: .continueSigning),
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
  confirmSelectionTitle: String,
  documentName: String,
  viewString: String,
  view: @escaping () -> Void
) -> some View {
  
  Text(confirmSelectionTitle)
    .font(Theme.shared.font.bodyLarge.font)
    .foregroundStyle(Theme.shared.color.onSurface)

  CardView(
    title: documentName,
    trailingView: {
      Text(viewString)
        .font(Theme.shared.font.bodyLarge.font)
    },
    action: {
      view()
    },
    trailingAction: {
      view()
    }
  )

  Spacer()
}

#Preview {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "title"
  ) {
    content(
      confirmSelectionTitle: "confirmSelectionTitle",
      documentName: "documentName",
      viewString: "View",
      view: {}
    )
  }
}

#Preview("Dark Mode") {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "title"
  ) {
    content(
      confirmSelectionTitle: "confirmSelectionTitle",
      documentName: "documentName",
      viewString: "View",
      view: {}
    )
  }
  .darkModePreview()
}
