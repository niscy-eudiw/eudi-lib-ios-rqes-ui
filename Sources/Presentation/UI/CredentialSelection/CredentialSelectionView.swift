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
  @State private var selectedItem: String?
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
      VStack(alignment: .leading, spacing: SPACING_MEDIUM) {
        Text("You have chosen to sign the following document:")
          .font(Theme.shared.font.labelMedium.font)
          .foregroundStyle(Theme.shared.color.onSurface)

        CardView(
          title: "Document_Title.PDF",
          subtitle: "Signed by: Entrust"
        ) {
          Image(.verifiedUser)
        } action: {}
      }

      VStack(alignment: .leading, spacing: SPACING_SMALL) {
        Text("CERTIFICATE")
          .font(Theme.shared.font.labelMedium.font)
          .foregroundStyle(Theme.shared.color.onSurfaceVariant)

        Text("Please confirm signing with one of the following certificates:")
          .font(Theme.shared.font.labelMedium.font)
          .foregroundStyle(Theme.shared.color.onSurface)
      }

      List(viewModel.viewState.credentials) { item in
        HStack {
          Text(item.name)
          Spacer()
          if selectedItem == item.certificateURI.absoluteString {
            Image(systemName: "checkmark")
              .foregroundColor(.accentColor)
          }
        }
        .listRowInsets(EdgeInsets())
        .contentShape(Rectangle())
        .onTapGesture {
          if selectedItem == item.certificateURI.absoluteString {
            selectedItem = nil
          } else {
            selectedItem = item.certificateURI.absoluteString
          }
        }
      }
      .listStyle(.plain)
    }
    .onAppear {
      viewModel.fetchCredentials()
    }
    .withNavigationTitle(
      "Select certificate",
      trailingActions: [
        Action(title: "State") {
          viewModel.setFlowState(
            .sign(
              "Document_title.PDF",
              "JVBERi0xLjEKJcKlwrHDqwoKMSAwIG9iagogIDw8IC9UeXBlIC9DYXRhbG9nCiAgICAgL1BhZ2VzIDIgMCBSCiAgPj4KZW5kb2JqCgoyIDAgb2JqCiAgPDwgL1R5cGUgL1BhZ2VzCiAgICAgL0tpZHMgWzMgMCBSXQogICAgIC9Db3VudCAxCiAgICAgL01lZGlhQm94IFswIDAgMzAwIDE0NF0KICA+PgplbmRvYmoKCjMgMCBvYmoKICA8PCAgL1R5cGUgL1BhZ2UKICAgICAgL1BhcmVudCAyIDAgUgogICAgICAvUmVzb3VyY2VzCiAgICAgICA8PCAvRm9udAogICAgICAgICAgIDw8IC9GMQogICAgICAgICAgICAgICA8PCAvVHlwZSAvRm9udAogICAgICAgICAgICAgICAgICAvU3VidHlwZSAvVHlwZTEKICAgICAgICAgICAgICAgICAgL0Jhc2VGb250IC9UaW1lcy1Sb21hbgogICAgICAgICAgICAgICA+PgogICAgICAgICAgID4+CiAgICAgICA+PgogICAgICAvQ29udGVudHMgNCAwIFIKICA+PgplbmRvYmoKCjQgMCBvYmoKICA8PCAvTGVuZ3RoIDU1ID4+CnN0cmVhbQogIEJUCiAgICAvRjEgMTggVGYKICAgIDAgMCBUZAogICAgKEhlbGxvIFdvcmxkKSBUagogIEVUCmVuZHN0cmVhbQplbmRvYmoKCnhyZWYKMCA1CjAwMDAwMDAwMDAgNjU1MzUgZiAKMDAwMDAwMDAxOCAwMDAwMCBuIAowMDAwMDAwMDc3IDAwMDAwIG4gCjAwMDAwMDAxNzggMDAwMDAgbiAKMDAwMDAwMDQ1NyAwMDAwMCBuIAp0cmFpbGVyCiAgPDwgIC9Sb290IDEgMCBSCiAgICAgIC9TaXplIDUKICA+PgpzdGFydHhyZWYKNTY1CiUlRU9GCg=="
            )
          )
          viewModel.onPause()
        },
        Action(title: "Proceed") {
          viewModel.signDocument()
        }
      ],
      leadingActions: [
        Action(title: "Cancel") {
          viewModel.onCancel()
        }
      ]
    )
  }
}
