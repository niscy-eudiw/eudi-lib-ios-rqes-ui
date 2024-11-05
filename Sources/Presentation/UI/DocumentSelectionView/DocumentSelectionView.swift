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
  @StateObject var viewModel: DocumentSelectionViewModel<Router>

  private let localization = DIGraph.resolver.force(
    LocalizationController.self
  )

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
    content(
      confirmSelectionTitle: viewModel.resource(.confirmSelectionTitle),
      confirmSelection: viewModel.resource(.confirmSelection),
      documentName: viewModel.viewState.document.documentName,
      viewString: viewModel.resource(.view),
      cancel: viewModel.resource(.cancel),
      view: viewModel.viewDocument,
      select: viewModel.selectService,
      dismiss: viewModel.onCancel
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  confirmSelectionTitle: String,
  confirmSelection: String,
  documentName: String,
  viewString: String,
  cancel: String,
  view: @escaping () -> Void,
  select: @escaping () -> Void,
  dismiss: @escaping () -> Void
) -> some View {
  ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
    Text(confirmSelectionTitle)
      .font(Theme.shared.font.labelMedium.font)
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
  .withNavigationTitle(
    confirmSelection,
    leadingActions: [
      Action(
        title: cancel,
        callback: dismiss
      )
    ]
  )
  .eraseToAnyView()
}

#Preview {
  content(
    confirmSelectionTitle: "confirmSelectionTitle",
    confirmSelection: "confirmSelection",
    documentName: "documentName",
    viewString: "View",
    cancel: "Cancel",
    view: {},
    select: {},
    dismiss: {}
  )
}
