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
import RqesKit

@Copyable
struct CredentialSelectionState: ViewState {
  let isLoading: Bool
  let credentials: [CredentialDataUIModel]
  let documentName: String
  let error: ContentErrorView.Config?
  let credentialInfos: [CredentialInfo]
  let selectedCredential: CredentialInfo?
}

final class CredentialSelectionViewModel<Router: RouterGraph>: ViewModel<Router, CredentialSelectionState> {
  
  private let interactor: RQESInteractor
  
  @Published var document: DocumentData?
  @Published var qtspName: String?
  
  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: CredentialSelectionState(
        isLoading: true,
        credentials: [],
        documentName: "",
        error: nil,
        credentialInfos: [],
        selectedCredential: nil
      )
    )
  }
  
  func initiate() async {
    do {
      try await fetchCredentials()
      try await getDocument()
    } catch {
      setErrorState {
        self.onCancel()
      }
    }
  }
  
  func setCertificate(_ certificate: CredentialDataUIModel? = nil) {
    Task {
      if let credential = viewState.credentialInfos.first(where: { $0.credentialID == certificate?.id}) {
        await interactor.saveCertificate(credential)
      }
    }
  }
  
  func nextStep() {
    onPause()
    openAuthorization()
  }
  
  func openAuthorization() {
    Task {
      do {
        let authorizationUrl = try await interactor.openCredentialAuthrorizationURL()
        await UIApplication.shared.openURLIfPossible(authorizationUrl) {
          self.setErrorState {
            self.setState { $0.copy(error: nil) }
          }
        }
      } catch {
        self.setErrorState {
          self.setState { $0.copy(error: nil) }
        }
      }
    }
  }
  
  private func fetchCredentials() async throws {
    do {
      let credentials = try await interactor.fetchCredentials()
      switch credentials {
      case .success(let credentials):
        setState {
          $0.copy(
            isLoading: false,
            credentials: credentials.map { $0.toUi() },
            credentialInfos: credentials
          )
          .copy(error: nil)
        }
      case .failure:
        throw EudiRQESUiError.unableToFetchCredentials
      }
    } catch {
      throw EudiRQESUiError.unableToFetchCredentials
    }
  }
  
  private func getDocument() async throws {
    let documentName = await interactor.getCurrentSelection()?.document?.documentName
    
    if let documentName {
      setState {
        $0.copy(
          isLoading: false,
          documentName: documentName
        )
        .copy(error: nil)
      }
    } else {
      throw EudiRQESUiError.noDocumentProvided
    }
  }
  
  private func setErrorState(cancelAction: @escaping () -> ()) {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: .genericErrorDocumentNotFound,
          cancelAction: cancelAction,
          action: { Task { await self.initiate() } }
        )
      )
    }
  }
}
