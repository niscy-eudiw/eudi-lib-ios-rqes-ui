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
struct SignedDocumenState: ViewState {
  let document: DocumentData?
//  let name: String
//  let contents: String
  let qtsp: QTSPData?
  let error: ContentErrorView.Config?
}

class SignedDocumentViewModel<Router: RouterGraph>: ViewModel<Router, SignedDocumenState> {

  private let interactor: RQESInteractor

  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: SignedDocumenState(
        document: nil,
        qtsp: nil,
        error: nil
      )
    )

    Task {
      let selection = try? await EudiRQESUi.instance().selection

      setState {
        $0
          .copy(
            document: selection?.document,
            qtsp: selection?.qtsp
          )
      }
    }
  }
  
  func viewDocument() {
    if let router = router as? RouterGraphImpl {
      router.navigateTo(
        .viewDocument(true)
      )
    }
  }
}

