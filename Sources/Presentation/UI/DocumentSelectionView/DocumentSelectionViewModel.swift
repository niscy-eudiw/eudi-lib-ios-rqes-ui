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
  let isLoading: Bool
  let document: DocumentData?
  let documentName: String
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
        isLoading: true,
        document: nil,
        documentName: "",
        error: nil
      )
    )
  }
  
  func initiate() async {
    let documentName = await interactor.getSession()?.document?.documentName
    
    if let documentName {
      setState {
        $0.copy(
          isLoading: false,
          documentName: documentName
        )
        .copy(error: nil)
      }
    } else {
      setState {
        $0.copy(
          isLoading: false,
          error: ContentErrorView.Config(
            title: .genericErrorMessage,
            description: .genericErrorDocumentNotFound,
            cancelAction: onCancel,
            action: { Task { await self.initiate() } }
          )
        )
      }
    }
  }
  
  func viewDocument() {
    router.navigateTo(.viewDocument(false))
  }
  
  func selectService() {
    router.navigateTo(.serviceSelection)
  }
}
