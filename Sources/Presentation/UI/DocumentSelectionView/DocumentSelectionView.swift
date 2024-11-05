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
    document: URL,
    services: [URL]
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
      localization: localization,
      view: viewModel.viewDocument,
      select: viewModel.selectService,
      dismiss: viewModel.onCancel
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  localization: LocalizationController,
  view: @escaping () -> Void,
  select: @escaping () -> Void,
  dismiss: @escaping () -> Void
) -> some View {
  ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
    Text(localization.get(with: .confirmSelectionTitle, args: []))
      .font(Theme.shared.font.labelMedium.font)
      .foregroundStyle(Theme.shared.color.onSurface)

    CardView(
      title: "Document_Title.PDF",
      trailingView: {
        Text(localization.get(with: .view, args: []))
          .font(Theme.shared.font.bodyLarge.font)
      },
      action: {
        view()
      }
    )

    CardView(
      title: "Select RSSP",
      trailingView: {
        Text(localization.get(with: .view, args: []))
          .font(Theme.shared.font.bodyLarge.font)
      },
      action: {
        select()
      }
    )

    Spacer()
  }
  .withNavigationTitle(
    localization.get(with: .confirmSelection, args: []),
    leadingActions: [
      Action(
        title: localization.get(with: .cancel, args: []),
        callback: dismiss
      )
    ]
  )
  .eraseToAnyView()
}

#Preview {
  let localization = DIGraph.resolver.force(
    LocalizationController.self
  )

  content(
    localization: localization,
    view: {},
    select: {},
    dismiss: {}
  )
}
