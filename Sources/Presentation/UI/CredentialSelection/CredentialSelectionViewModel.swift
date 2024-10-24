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
struct CredentialSelectionState: ViewState {
  let credentials: [String]
}

class CredentialSelectionViewModel<Router: RouterGraph>: ViewModel<Router, CredentialSelectionState> {
  
  override init(
    router: Router,
    initialState: CredentialSelectionState = .init(credentials: [])
  ) {
    super.init(
      router: router,
      initialState: initialState
    )
  }
  
  func fetchCredentials() {
    setState {
      $0.copy(credentials: [
        "Certificate 1",
        "Certificate 2",
        "Certificate 3"
      ])
    }
  }
  
  func signDocument() {
    if let router = self.router as? RouterGraphImpl {
      router.navigateTo(
        .signedDocument(
          title: "Document_Title.PDF",
          contents: ""
        )
      )
    }
  }
}
