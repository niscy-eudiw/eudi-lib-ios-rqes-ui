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

  @State private var selectedItem: CredentialDataUIModel?
  @State private var showSheet = false

  @ObservedObject private var viewModel: CredentialSelectionViewModel<Router>

  init(with viewModel:CredentialSelectionViewModel<Router>) {
    self.viewModel = viewModel
  }

  var body: some View {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: localization.get(with: .selectCertificate),
      errorConfig: viewModel.viewState.error,
      isLoading: viewModel.viewState.isLoading,
      toolbarContent: toolbarAction()
    ) {
      content(
        title: localization.get(with: .selectCertificateTitle),
        documentName: viewModel.viewState.documentName,
        certificate: localization.get(with: .certificate),
        confirmSigning: localization.get(with: .selectCertificateSubtitle),
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
    .onAppear {
      viewModel.fetchCredentials()
      viewModel.getDocument()
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
  }

  private func toolbarAction() -> ToolBarContent? {
    return ToolBarContent(
      trailingActions: [
        Action(
          title: localization.get(with: .proceed),
          disabled: selectedItem == nil
        ) {
          viewModel.nextStep()
        }
      ],
      leadingActions: [
        Action(title: localization.get(with: .cancel)) {
          showSheet.toggle()
        }
      ]
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  title: String,
  documentName: String,
  certificate: String,
  confirmSigning: String,
  credentials: [CredentialDataUIModel],
  selectedItem: Binding<CredentialDataUIModel?>
) -> some View {
  VStack(alignment: .leading, spacing: SPACING_MEDIUM) {
    Text(title)
      .font(Theme.shared.font.bodyMedium.font)
      .foregroundStyle(Theme.shared.color.onSurface)

    CardView(
      title: documentName,
      trailingView: {}
    )
  }

  VStack(alignment: .leading, spacing: SPACING_SMALL) {
    Text(certificate)
      .font(Theme.shared.font.labelMedium.font)
      .foregroundStyle(Theme.shared.color.onSurfaceVariant)

    Text(confirmSigning)
      .font(Theme.shared.font.bodyMedium.font)
      .foregroundStyle(Theme.shared.color.onSurface)
  }

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
      title: "Select certificate"
    ) {
      content(
        title: "You have chosen to sign the following document:",
        documentName: "Document_Title.PDF",
        certificate: "CERTIFICATE",
        confirmSigning: "Please confirm signing with one of the following certificates:",
        credentials: [
          CredentialDataUIModel(id: "1", name: "Certificate 1"),
          CredentialDataUIModel(id: "2", name: "Certificate 2"),
          CredentialDataUIModel(id: "4", name: "Certificate 3")
        ],
        selectedItem: .constant(CredentialDataUIModel(id: "4", name: "Certificate 3"))
      )
    }
    .lightModePreview()
}

#Preview("Dark Mode") {
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: "Select certificate"
    ) {
      content(
        title: "You have chosen to sign the following document:",
        documentName: "Document_Title.PDF",
        certificate: "CERTIFICATE",
        confirmSigning: "Please confirm signing with one of the following certificates:",
        credentials: [
          CredentialDataUIModel(id: "1", name: "Certificate 1"),
          CredentialDataUIModel(id: "2", name: "Certificate 2"),
          CredentialDataUIModel(id: "4", name: "Certificate 3")
        ],
        selectedItem: .constant(CredentialDataUIModel(id: "4", name: "Certificate 3"))
      )
    }
    .darkModePreview()
}
