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
  let isLoading: Bool
  let document: DocumentData?
  let qtsp: QTSPData?
  let documentName: String
  let qtspName: String
  let error: ContentErrorView.Config?
  let isInitialized: Bool
}

class SignedDocumentViewModel<Router: RouterGraph>: ViewModel<Router, SignedDocumenState> {
  
  private let interactor: RQESInteractor
  @Published var pdfURL: URL?
  
  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: SignedDocumenState(
        isLoading: true,
        document: nil,
        qtsp: nil,
        documentName: "",
        qtspName: "",
        error: nil,
        isInitialized: false
      )
    )
  }
  
  func initiate() async {
    
    guard !viewState.isInitialized else { return }
    
    do {
      let signedDocument = try await interactor.signDocument()
      let selection = await interactor.getSession()
      
      pdfURL = signedDocument?.fileURL
      if let fileURL = signedDocument?.fileURL {
        await interactor.updateDocument(fileURL)
      }
      
      if let documentName = selection?.document?.documentName,
         let qtspName = selection?.qtsp?.name {
        setState {
          $0.copy(
            isLoading: false,
            documentName: documentName,
            qtspName: qtspName,
            isInitialized: true
          )
          .copy(error: nil)
        }
      } else {
        setErrorState {
          self.onCancel()
        }
      }
    } catch {
      setErrorState {
        Task { await self.initiate() }
      }
    }
  }
  
  func viewDocument() {
    router.navigateTo(.viewDocument(true))
  }
  
  private func setErrorState(retryAction: @escaping () -> ()) {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: .genericErrorDocumentNotFound,
          cancelAction: onCancel,
          action: retryAction
        )
      )
    }
  }
}

