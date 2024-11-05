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

struct ServiceSelectionView<Router: RouterGraph>: View {
  @StateObject var viewModel: ServiceSelectionViewModel<Router>
  @State private var selectedItem: String?

  init(
    router: Router,
    services: [QTSPData]
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        router: router,
        initialState: .init(
          services: services
        )
      )
    )
  }

  var body: some View {
    ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
      content(
        selectServiceTitle: viewModel.resource(.selectServiceTitle),
        selectServiceSubtitle: viewModel.resource(.selectServiceSubtitle),
        services: viewModel.viewState.services,
        selectedItem: $selectedItem
      )
    }
    .withNavigationTitle(
      viewModel.resource(.selectService),
      trailingActions: [
        Action(
          title: viewModel.resource(.state),
          callback: {
            viewModel.setFlowState(
              .credentials
            )
            viewModel.onPause()
          }
        ),
        Action(
          title: viewModel.resource(.proceed),
          callback: viewModel.selectCredential
        )
      ]
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  selectServiceTitle: String,
  selectServiceSubtitle: String,
  services: [QTSPData],
  selectedItem: Binding<String?>
) -> some View {
  Text(selectServiceTitle)
    .font(Theme.shared.font.labelMedium.font)
    .foregroundStyle(Theme.shared.color.onSurface)

  Text(selectServiceSubtitle)
    .font(Theme.shared.font.labelMedium.font)
    .foregroundStyle(Theme.shared.color.onSurface)

  List(services, id: \.qtspName) { item in
    HStack {
      Text(item.qtspName)
      Spacer()
      if selectedItem.wrappedValue == item.uri.absoluteString {
        Image(systemName: "checkmark")
          .foregroundColor(.accentColor)
      }
    }
    .listRowInsets(EdgeInsets())
    .contentShape(Rectangle())
    .onTapGesture {
      if selectedItem.wrappedValue == item.uri.absoluteString {
        selectedItem.wrappedValue = nil
      } else {
        selectedItem.wrappedValue = item.uri.absoluteString
      }
    }
  }
  .listStyle(.plain)
}

#Preview {
  ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
    content(
      selectServiceTitle: "Select remote signing service.",
      selectServiceSubtitle: "Remote signing enables you to digitally sign documents without the need for locally installed digital identities. Cloud-hosted signing service makes remote signing possible.",
      services: [
        QTSPData(qtspName: "Entrust", uri: URL(string: "https://www.entrust.com")!),
        QTSPData(qtspName: "Docusign", uri: URL(string: "https://www.docusign.com")!),
        QTSPData(qtspName: "Ascertia", uri: URL(string: "https://www.ascertia.com")!)
      ],
      selectedItem: .constant("")
    )
  }
}
