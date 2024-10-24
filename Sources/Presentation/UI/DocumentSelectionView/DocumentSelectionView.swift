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

struct DocumentSelectionView<Router: RouterGraph>: View {
  @StateObject var viewModel: DocumentSelectionViewModel<Router>
  
  init(
    router: Router,
    document: URL,
    services: [URL]
  ) {
    _viewModel = .init(
      wrappedValue: .init(
        router: router,
        initialState: .init(
          document: document,
          services: services
        )
      )
    )
  }
  
  var body: some View {
    content(
      view: viewModel.viewDocument,
      select: viewModel.selectService,
      dismiss: viewModel.onCancel
    )
  }
}

@MainActor
@ViewBuilder
private func content(
  view: @escaping () -> Void,
  select: @escaping () -> Void,
  dismiss: @escaping () -> Void
) -> some View {
  NavigationView {
    VStack(alignment: .center, spacing: 10.0) {
      Button(action: {
        view()
      }) {
        Text("View PDF")
          .foregroundColor(.blue)
      }
      
      Button(action: {
        select()
      }) {
        Text("Select RSSP")
          .foregroundColor(.blue)
      }
      
      Spacer()
    }
    .navigationTitle("Confirm Selection")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button(action: {
          dismiss()
        }) {
          Text("Close")
        }
      }
    }
  }
  .eraseToAnyView()
}
