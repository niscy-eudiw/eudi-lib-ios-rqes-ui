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

struct SignedDocumentView<Router: RouterGraph>: View {
  @StateObject var viewModel: SignedDocumentViewModel<Router>

  init(
    router: Router,
    initialState: SignedDocumenState
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        router: router,
        initialState: initialState
      )
    )
  }

  var body: some View {
    ContentScreenView(spacing: SPACING_LARGE_MEDIUM) {
      VStack(alignment: .leading, spacing: SPACING_NONE) {
        Text("Success")
          .font(Theme.shared.font.headlineLarge.font)
          .foregroundStyle(Theme.shared.color.success)
          .padding(.top, SPACING_LARGE_MEDIUM)

        VStack(alignment: .leading, spacing: SPACING_NONE) {
          Text("You successfully signed your document")
            .foregroundStyle(Theme.shared.color.onSurface)

          Text(viewModel.viewState.name)
            .foregroundStyle(Theme.shared.color.onSurface)
            .fontWeight(.semibold)
            .leftImage(image: Image(.verifiedUser))
        }
        .padding(.top, SPACING_SMALL)

        CardView(
          type: .success,
          title: viewModel.viewState.name,
          subtitle: "Signed by: Entrust",
          trailingView: {
            Text("View")
              .font(Theme.shared.font.bodyLarge.font)
          },
          action: { viewModel.viewDocument() },
          trailingAction: { viewModel.viewDocument() }
        )
        .padding(.top, SPACING_MEDIUM)
      }

      Spacer()
    }
    .withNavigationTitle(
      "Document signed",
      trailingActions: [
        Action(
          title: "Done",
          callback: viewModel.onPause
        )
      ]
    )
  }
}
