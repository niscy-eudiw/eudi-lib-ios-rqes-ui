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

struct CredentialSelectionView<Router: RouterGraph>: View {
  
  @Environment(\.localizationController) var localization
  @ObservedObject private var viewModel: CredentialSelectionViewModel<Router>
  
  @State private var selectedItem: CredentialDataUIModel?

  init(with viewModel:CredentialSelectionViewModel<Router>) {
    self.viewModel = viewModel
  }

  var body: some View {
    ContentScreenView(
      canScroll: true,
      spacing: SPACING_LARGE_MEDIUM,
      title: .selectCertificate,
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: toolbarAction()
    ) {
      content(
        credentials: viewModel.viewState.credentials,
        selectedItem: $selectedItem
      )
      .onChange(of: selectedItem) { newValue in
        if let newValue {
          viewModel.setCertificate(newValue)
        } else {
          viewModel.setCertificate(nil)
        }
      }
    }
    .task {
      await viewModel.initiate()
    }
  }

  private func toolbarAction() -> ToolBarContent? {
    return ToolBarContent(
      trailingActions: [
        Action(
          title: .proceed,
          disabled: selectedItem == nil
        ) {
          viewModel.nextStep()
        }
      ]
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  credentials: [CredentialDataUIModel],
  selectedItem: Binding<CredentialDataUIModel?>
) -> some View {
  List(credentials) { item in
    HStack {
      Text(item.name)
        .font(Theme.shared.font.bodyMedium.font)
        .foregroundStyle(Theme.shared.color.onSurface)
      Spacer()
      if item.id == selectedItem.wrappedValue?.id {
        Image(systemName: "checkmark")
          .foregroundColor(.accentColor)
      }
    }
    .listRowInsets(EdgeInsets())
    .contentShape(Rectangle())
    .onTapGesture {
      if item.id == selectedItem.wrappedValue?.id {
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
      title: .custom("Select certificate")
    ) {
      content(
        credentials: [
          CredentialDataUIModel(id: "1", name: "Certificate 1"),
          CredentialDataUIModel(id: "2", name: "Certificate 2"),
          CredentialDataUIModel(id: "4", name: "Certificate 3")
        ],
        selectedItem: .constant(CredentialDataUIModel(id: "4", name: "Certificate 3"))
      )
    }
    .environment(\.localizationController, PreviewLocalizationController())
    .lightModePreview()
}

#Preview("Dark Mode") {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: .custom("Select certificate")
    ) {
      content(
        credentials: [
          CredentialDataUIModel(id: "1", name: "Certificate 1"),
          CredentialDataUIModel(id: "2", name: "Certificate 2"),
          CredentialDataUIModel(id: "4", name: "Certificate 3")
        ],
        selectedItem: .constant(CredentialDataUIModel(id: "4", name: "Certificate 3"))
      )
    }
    .environment(\.localizationController, PreviewLocalizationController())
    .darkModePreview()
}
