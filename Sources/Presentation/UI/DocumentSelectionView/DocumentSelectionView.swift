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
  @StateObject var viewModel: DocumentSelectionViewModel<Router>

  @State private var showSheet = false

  init(
    router: Router,
    document: DocumentData,
    services: [QTSPData]
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        router: router,
        initialState: .init(
          document: document,
          services: services
        )
      )
    )
  }

  var body: some View {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: localization.get(with: .confirmSelection),
      toolbarContent: .init(
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
        documentName: viewModel.viewState.document.documentName,
        viewString: localization.get(with: .view),
        view: viewModel.viewDocument,
        select: viewModel.selectService
      )
    }
    .confirmationDialog(
      localization.get(with: .cancelSigningProcessTitle),
      isPresented: $showSheet,
      titleVisibility: .visible
    ) {
      Button(
        localization.get(with: .cancelSigning),
        role: .destructive
      ) {
        viewModel.onCancel()
      }
      Button(
        localization.get(with: .continueSigning),
        role: .cancel) {
          showSheet.toggle()
      }
    }
    .eraseToAnyView()
  }
}

@MainActor
@ViewBuilder
private func content(
  confirmSelectionTitle: String,
  documentName: String,
  viewString: String,
  view: @escaping () -> Void,
  select: @escaping () -> Void
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
      select()
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
      view: {},
      select: {}
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
      view: {},
      select: {}
    )
  }
  .darkModePreview()
}
