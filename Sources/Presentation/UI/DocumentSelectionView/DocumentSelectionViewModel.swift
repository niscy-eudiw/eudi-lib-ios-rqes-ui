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

@Copyable
struct DocumentSelectionState: ViewState {
  let document: DocumentData?
  let services: [QTSPData]
  let error: ContentErrorView.Config?
}

class DocumentSelectionViewModel<Router: RouterGraph>: ViewModel<Router, DocumentSelectionState> {

  private let interactor: RQESInteractor

  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: DocumentSelectionState(
        document: nil,
        services: [],
        error: nil)
    )
  }

  func initiate() {
    Task {
      let document = try? await interactor.getCurrentSelection()?.document

      if let name = document?.documentName {
        setState {
          $0
            .copy(
              document: document
            )
        }
      } else {
        setState {
          $0
            .copy(
              error: ContentErrorView.Config(
                title: .genericErrorMessage,
                description: .genericErrorDocumentNotFound,
                cancelAction: {}(),
                action: initiate
              )
            )
        }
      }
    }
  }

  func viewDocument() {
    if let router = self.router as? RouterGraphImpl {
      router.navigateTo(
        .viewDocument(false)
      )
    }
  }
  
  func selectService() {
    if let router = self.router as? RouterGraphImpl {
      router.navigateTo(
        .serviceSelection
      )
    }
  }
}
