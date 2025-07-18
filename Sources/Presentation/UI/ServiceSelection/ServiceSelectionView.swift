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
import RqesKit

struct ServiceSelectionView<Router: RouterGraph>: View {
  
  @Environment(\.localizationController) var localization
  @ObservedObject var viewModel: ServiceSelectionViewModel<Router>

  init(with viewModel:ServiceSelectionViewModel<Router>) {
    self.viewModel = viewModel
  }

  var body: some View {
    ContentScreenView(
      canScroll: true,
      spacing: SPACING_LARGE_MEDIUM,
      title: .selectService,
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: ToolBarContent(
        trailingActions: [
          Action(
            title: .proceed,
            disabled: viewModel.selectedItem == nil,
            callback: {
              viewModel.nextStep()
            }
          )
        ]
      )
    ) {
      content(
        services: viewModel.viewState.services,
        selectedItem: $viewModel.selectedItem
      )
      .task {
        await viewModel.initiate()
      }
    }
  }
}

@MainActor
@ViewBuilder
private func content(
  services: [QTSPData],
  selectedItem: Binding<QTSPData?>
) -> some View {
  List(services, id: \.name) { item in
    HStack {
      Text(item.name)
        .font(Theme.shared.font.bodyMedium.font)
        .foregroundStyle(Theme.shared.color.onSurface)
      Spacer()
      if selectedItem.wrappedValue?.rsspId == item.rsspId {
        Image(systemName: "checkmark")
          .foregroundColor(.accentColor)
      }
    }
    .listRowInsets(EdgeInsets())
    .contentShape(Rectangle())
    .onTapGesture {
      if selectedItem.wrappedValue?.rsspId == item.rsspId {
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
    title: .custom("Navigation Title")
  ) {
    content(
      services: [
        QTSPData(
          name: "Entrust",
          rsspId: "https://www.entrust.com",
          tsaUrl: nil,
          clientId: "clientId",
          clientSecret: "clientSecret",
          authFlowRedirectionURI: "authFlowRedirectionURI",
          hashAlgorithm: HashAlgorithmOID.SHA256
        )
      ],
      selectedItem: .constant(
        QTSPData(
          name: "Entrust",
          rsspId: "https://www.entrust.com",
          tsaUrl: nil,
          clientId: "clientId",
          clientSecret: "clientSecret",
          authFlowRedirectionURI: "authFlowRedirectionURI",
          hashAlgorithm: HashAlgorithmOID.SHA256
        )
      )
    )
  }
  .environment(\.localizationController, PreviewLocalizationController())
}

#Preview("Dark Mode") {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: .custom("Navigation Title")
  ) {
    content(
      services: [
        QTSPData(
          name: "Entrust",
          rsspId: "https://www.entrust.com",
          tsaUrl: nil,
          clientId: "clientId",
          clientSecret: "clientSecret",
          authFlowRedirectionURI: "authFlowRedirectionURI",
          hashAlgorithm: HashAlgorithmOID.SHA256
        )
      ],
      selectedItem: .constant(
        QTSPData(
          name: "Entrust",
          rsspId: "https://www.entrust.com",
          tsaUrl: nil,
          clientId: "clientId",
          clientSecret: "clientSecret",
          authFlowRedirectionURI: "authFlowRedirectionURI",
          hashAlgorithm: HashAlgorithmOID.SHA256
        )
      )
    )
  }
  .darkModePreview()
  .environment(\.localizationController, PreviewLocalizationController())
}
