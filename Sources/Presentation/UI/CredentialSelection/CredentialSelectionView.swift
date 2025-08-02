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
