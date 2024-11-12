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
  @Environment(\.localizationController) var localization
  @ObservedObject var viewModel: ServiceSelectionViewModel<Router>
  @State private var selectedItem: QTSPData?

  init(with viewModel:ServiceSelectionViewModel<Router>) {
    self.viewModel = viewModel
  }

  var body: some View {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: localization.get(with: .selectService),
      toolbarContent: ToolBarContent(
        trailingActions: [
          Action(
            title: localization.get(with: .state),
            callback: {
              viewModel.setFlowState(
                .credentials
              )
              viewModel.onPause()
            }
          )
        ]
      )
    ) {
      content(
        selectServiceTitle: localization.get(with: .selectServiceTitle),
        selectServiceSubtitle: localization.get(with: .selectServiceSubtitle),
        services: viewModel.viewState.services,
        selectedItem: $selectedItem
      )
      .onChange(of: selectedItem) { newValue in
        if let newValue = newValue {
          viewModel.selectQTSP(newValue)
        } else {
          viewModel.selectQTSP(nil)
        }
      }
      .onAppear {
        viewModel.initiate()
      }
    }
  }
}

@MainActor
@ViewBuilder
private func content(
  selectServiceTitle: String,
  selectServiceSubtitle: String,
  services: [QTSPData],
  selectedItem: Binding<QTSPData?>
) -> some View {
  Text(selectServiceTitle)
    .font(Theme.shared.font.bodyLarge.font)
    .foregroundStyle(Theme.shared.color.onSurface)

  Text(selectServiceSubtitle)
    .font(Theme.shared.font.bodyMedium.font)
    .foregroundStyle(Theme.shared.color.onSurface)

  List(services, id: \.qtspName) { item in
    HStack {
      Text(item.qtspName)
        .font(Theme.shared.font.bodyMedium.font)
        .foregroundStyle(Theme.shared.color.onSurface)
      Spacer()
      if selectedItem.wrappedValue?.uri == item.uri {
        Image(systemName: "checkmark")
          .foregroundColor(.accentColor)
      }
    }
    .listRowInsets(EdgeInsets())
    .contentShape(Rectangle())
    .onTapGesture {
      if selectedItem.wrappedValue?.uri == item.uri {
        selectedItem.wrappedValue = nil
      } else {
        selectedItem.wrappedValue = item
      }
    }
  }
  .listStyle(.plain)
}

#Preview {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "Navigation Title"
  ) {
    content(
      selectServiceTitle: "Select remote signing service.",
      selectServiceSubtitle: "Remote signing enables you to digitally sign documents without the need for locally installed digital identities. Cloud-hosted signing service makes remote signing possible.",
      services: [
        QTSPData(qtspName: "Entrust", uri: URL(string: "https://www.entrust.com")!),
        QTSPData(qtspName: "Docusign", uri: URL(string: "https://www.docusign.com")!),
        QTSPData(qtspName: "Ascertia", uri: URL(string: "https://www.ascertia.com")!)
      ],
      selectedItem: .constant(
        QTSPData(
          qtspName: "Entrust",
          uri: URL(string: "https://www.entrust.com")!
        )
      )
    )
  }
}

#Preview("Dark Mode") {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "Navigation Title"
  ) {
    content(
      selectServiceTitle: "Select remote signing service.",
      selectServiceSubtitle: "Remote signing enables you to digitally sign documents without the need for locally installed digital identities. Cloud-hosted signing service makes remote signing possible.",
      services: [
        QTSPData(qtspName: "Entrust", uri: URL(string: "https://www.entrust.com")!),
        QTSPData(qtspName: "Docusign", uri: URL(string: "https://www.docusign.com")!),
        QTSPData(qtspName: "Ascertia", uri: URL(string: "https://www.ascertia.com")!)
      ],
      selectedItem: .constant(
        QTSPData(
          qtspName: "Entrust",
          uri: URL(string: "https://www.entrust.com")!
        )
      )
    )
  }
  .darkModePreview()
}
