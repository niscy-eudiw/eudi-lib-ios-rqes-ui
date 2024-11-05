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
    services: [URL]
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
      Text("Select remote signing service.")
        .font(Theme.shared.font.labelMedium.font)
        .foregroundStyle(Theme.shared.color.onSurface)

      Text("Remote signing enables you to digitally sign documents without the need for locally installed digital identities. Cloud-hosted signing service makes remote signing possible.")
        .font(Theme.shared.font.labelMedium.font)
        .foregroundStyle(Theme.shared.color.onSurface)

      List(viewModel.viewState.services, id: \.self) { item in
        HStack {
          Text(item.absoluteString)
          Spacer()
          if selectedItem == item.absoluteString {
            Image(systemName: "checkmark")
              .foregroundColor(.blue)
          }
        }
        .listRowInsets(EdgeInsets())
        .contentShape(Rectangle())
        .onTapGesture {
          if selectedItem == item.absoluteString {
            selectedItem = nil
          } else {
            selectedItem = item.absoluteString
          }
        }
      }
      .listStyle(.plain)
    }
    .withNavigationTitle(
      "Select service",
      trailingActions: [
        Action(
          title: "State",
          callback: {
            viewModel.setFlowState(
              .credentials
            )
            viewModel.onPause()
          }
        ),
        Action(
          title: "Proceed",
          callback: viewModel.selectCredential
        )
      ]
    )
  }
}
