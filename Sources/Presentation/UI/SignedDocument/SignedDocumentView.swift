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
  @Environment(\.localizationController) var localization

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
    ContentScreenView(
      spacing: SPACING_LARGE_MEDIUM,
      title: localization.get(with: .documentSigned),
      toolbarContent: ToolBarContent(
        trailingActions: [
          Action(
            title: localization.get(with: .save),
            callback: {
              viewModel.onPause()
            }
          )
        ]
      )
    ) {
      content(
        success: localization.get(with: .success),
        successfullySigned: localization.get(with: .successfullySignedDocument),
        documentName: viewModel.viewState.name,
        signedBy: localization.get(with: .signedBy, args: ["Entrust"]),
        viewString: localization.get(with: .view),
        view: viewModel.viewDocument
      )
    }
  }
}

@MainActor
@ViewBuilder
private func content(
  success: String,
  successfullySigned: String,
  documentName: String,
  signedBy: String,
  viewString: String,
  view: @escaping () -> Void
) -> some View {
  VStack(alignment: .leading, spacing: SPACING_NONE) {
    Text(success)
      .font(Theme.shared.font.headlineLarge.font)
      .foregroundStyle(Theme.shared.color.success)
      .padding(.top, SPACING_LARGE_MEDIUM)

    VStack(alignment: .leading, spacing: SPACING_NONE) {
      Text(successfullySigned)
        .foregroundStyle(Theme.shared.color.onSurface)

      Text(documentName)
        .foregroundStyle(Theme.shared.color.onSurface)
        .fontWeight(.semibold)
        .leftImage(image: Image(.verifiedUser))
    }
    .padding(.top, SPACING_SMALL)

    CardView(
      type: .success,
      title: documentName,
      subtitle: signedBy,
      trailingView: {
        Text(viewString)
          .font(Theme.shared.font.bodyLarge.font)
      },
      action: { view() },
      trailingAction: { view() }
    )
    .padding(.top, SPACING_MEDIUM)

    Spacer()
  }
}

#Preview {
  ContentScreenView(
    spacing: SPACING_LARGE_MEDIUM,
    title: "Navigation title"
  ) {
    content(
      success: "Success",
      successfullySigned: "You successfully signed your document",
      documentName: "Document title",
      signedBy: "Signed by: Entrust",
      viewString: "View",
      view: {}
    )
  }
}
