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
  @Environment(\.dismiss) var dismiss

  @State private var selectedItem: String?
  @State private var showSheet = false

  @StateObject var viewModel: CredentialSelectionViewModel<Router>

  private let localization = DIGraph.resolver.force(
    LocalizationController.self
  )

  init(
    router: Router
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        router: router
      )
    )
  }

  var body: some View {
    ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
      content(
        title: viewModel.resource(.selectCertificateTitle),
        documentName: "Document_Title.PDF",
        signedBy: viewModel.resource(.signedBy, args: ["Entrust"]),
        certificate: viewModel.resource(.certificate),
        confirmSigning: viewModel.resource(.selectCertificateSubtitle),
        credentials: viewModel.viewState.credentials,
        selectedItem: $selectedItem
      )
    }
    .onAppear {
      viewModel.fetchCredentials()
    }
    .withNavigationTitle(
      viewModel.resource(.selectCertificate),
      trailingActions: [
        Action(title: viewModel.resource(.state)) {
          viewModel.setFlowState(
            .sign(
              "Document_title.PDF",
              "JVBERi0xLjEKJcKlwrHDqwoKMSAwIG9iagogIDw8IC9UeXBlIC9DYXRhbG9nCiAgICAgL1BhZ2VzIDIgMCBSCiAgPj4KZW5kb2JqCgoyIDAgb2JqCiAgPDwgL1R5cGUgL1BhZ2VzCiAgICAgL0tpZHMgWzMgMCBSXQogICAgIC9Db3VudCAxCiAgICAgL01lZGlhQm94IFswIDAgMzAwIDE0NF0KICA+PgplbmRvYmoKCjMgMCBvYmoKICA8PCAgL1R5cGUgL1BhZ2UKICAgICAgL1BhcmVudCAyIDAgUgogICAgICAvUmVzb3VyY2VzCiAgICAgICA8PCAvRm9udAogICAgICAgICAgIDw8IC9GMQogICAgICAgICAgICAgICA8PCAvVHlwZSAvRm9udAogICAgICAgICAgICAgICAgICAvU3VidHlwZSAvVHlwZTEKICAgICAgICAgICAgICAgICAgL0Jhc2VGb250IC9UaW1lcy1Sb21hbgogICAgICAgICAgICAgICA+PgogICAgICAgICAgID4+CiAgICAgICA+PgogICAgICAvQ29udGVudHMgNCAwIFIKICA+PgplbmRvYmoKCjQgMCBvYmoKICA8PCAvTGVuZ3RoIDU1ID4+CnN0cmVhbQogIEJUCiAgICAvRjEgMTggVGYKICAgIDAgMCBUZAogICAgKEhlbGxvIFdvcmxkKSBUagogIEVUCmVuZHN0cmVhbQplbmRvYmoKCnhyZWYKMCA1CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxOCAwMDAwMCBuIAowMDAwMDAwMDc3IDAwMDAwIG4gCjAwMDAwMDAxNzggMDAwMDAgbiAKMDAwMDAwMDQ1NyAwMDAwMCBuIAp0cmFpbGVyCiAgPDwgIC9Sb290IDEgMCBSCiAgICAgIC9TaXplIDUKICA+PgpzdGFydHhyZWYKNTY1CiUlRU9GCg=="
            )
          )
          viewModel.onPause()
        },
        Action(
          title: viewModel.resource(.proceed)) {
            viewModel.signDocument()
          }
      ],
      leadingActions: [
        Action(title: viewModel.resource(.cancel)) {
          showSheet.toggle()
        }
      ]
    )
    .dynamicBottomSheet(isPresented: $showSheet) {
      bottomSheet()
    }
  }

  @ViewBuilder
  private func bottomSheet() -> some View {
    let cancelAction = BottomSheetAction(
      title: viewModel.resource(.cancelSigning),
      action: { dismiss() }
    )

    let deleteAction = BottomSheetAction(
      title: viewModel.resource(.continueSigning),
      action: { viewModel.onCancel() }
    )

    BottomSheetViewWithActions(
      title: viewModel.resource(.cancelSigningProcessTitle),
      subtitle: viewModel.resource(.cancelSigningProcessSubtitle),
      negativeAction: cancelAction,
      positiveAction: deleteAction
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  title: String,
  documentName: String,
  signedBy: String,
  certificate: String,
  confirmSigning: String,
  credentials: [CertificateData],
  selectedItem: Binding<String?>
) -> some View {
  VStack(alignment: .leading, spacing: SPACING_MEDIUM) {
    Text(title)
      .font(Theme.shared.font.labelMedium.font)
      .foregroundStyle(Theme.shared.color.onSurface)

    CardView(
      title: documentName,
      subtitle: signedBy
    ) {
      Image(.verifiedUser)
    } action: {}
  }

  VStack(alignment: .leading, spacing: SPACING_SMALL) {
    Text(certificate)
      .font(Theme.shared.font.labelMedium.font)
      .foregroundStyle(Theme.shared.color.onSurfaceVariant)

    Text(confirmSigning)
      .font(Theme.shared.font.labelMedium.font)
      .foregroundStyle(Theme.shared.color.onSurface)
  }

  List(credentials) { item in
    HStack {
      Text(item.name)
      Spacer()
      if selectedItem.wrappedValue == item.certificateURI.absoluteString {
        Image(systemName: "checkmark")
          .foregroundColor(.accentColor)
      }
    }
    .listRowInsets(EdgeInsets())
    .contentShape(Rectangle())
    .onTapGesture {
      if selectedItem.wrappedValue == item.certificateURI.absoluteString {
        selectedItem.wrappedValue = nil
      } else {
        selectedItem.wrappedValue = item.certificateURI.absoluteString
      }
    }
  }
  .listStyle(.plain)
}

#Preview {
  ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
    content(
      title: "You have chosen to sign the following document:",
      documentName: "Document_Title.PDF",
      signedBy: "Signed by:Entrust",
      certificate: "CERTIFICATE",
      confirmSigning: "Please confirm signing with one of the following certificates:",
      credentials: [
        CertificateData(name: "Certificate 1", certificateURI: URL(string: "uri 1")!),
        CertificateData(name: "Certificate 2", certificateURI: URL(string: "uri 2")!),
        CertificateData(name: "Certificate 3", certificateURI: URL(string: "uri 3")!)
      ],
      selectedItem: .constant("")
    )
  }
}
