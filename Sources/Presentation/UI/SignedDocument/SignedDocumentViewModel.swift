/*
 * Copyright (c) 2025 European Commission
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import SwiftUI

@Copyable
struct SignedDocumenState: ViewState {
  let isLoading: Bool
  let document: DocumentData?
  let qtsp: QTSPData?
  let documentName: String
  let qtspName: String
  let headerConfig: ContentHeaderConfig
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
        headerConfig: .init(
          appIconAndTextData: .init(
            appIcon: Image(.euWalletLogo),
            appText: Image(.eudiTextLogo)
          )
        ),
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
            headerConfig: .init(
              appIconAndTextData: .init(
                appIcon: Image(.euWalletLogo),
                appText: Image(.eudiTextLogo)
              ),
              description: ""
            ),
            isInitialized: true
          )
          .copy(error: nil)
        }
      } else {
        setErrorState(.genericErrorDocumentNotFound) {
          self.onCancel()
        }
      }
    } catch {
      setErrorState(.genericServiceErrorMessage) {
        Task { await self.initiate() }
      }
    }
  }
  
  func viewDocument() {
    router.navigateTo(.viewDocument(true))
  }
  
  private func setErrorState(
    _ desc: LocalizableKey,
    retryAction: @escaping () -> ()
  ) {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: desc,
          cancelAction: onCancel,
          action: retryAction
        )
      )
    }
  }
}

