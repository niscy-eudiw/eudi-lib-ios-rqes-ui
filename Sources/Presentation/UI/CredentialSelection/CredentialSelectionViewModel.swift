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
import RqesKit
import Observation

@Copyable
struct CredentialSelectionState: ViewState {
  let isLoading: Bool
  let credentials: [CredentialDataUIModel]
  let error: ContentErrorView.Config?
  let credentialInfos: [CredentialInfo]
  let selectedCredential: CredentialInfo?
}

@Observable
final class CredentialSelectionViewModel<Router: RouterGraph>: ViewModel<Router, CredentialSelectionState> {

  @ObservationIgnored
  private let interactor: RQESInteractor
  
  var document: DocumentData?
  var qtspName: String?
  
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
        error: nil,
        credentialInfos: [],
        selectedCredential: nil
      )
    )
  }
  
  func initiate() async {
    do {
      try await fetchCredentials()
    } catch {
      setErrorState(.genericServiceErrorMessage) {
        self.router.pop()
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
    openAuthorization()
  }
  
  private func openAuthorization() {
    Task {
      do {
        
        let authorizationUrl = try await interactor.openCredentialAuthrorizationURL()
        self.onPause()
        
        await UIApplication.shared.openURLIfPossible(authorizationUrl) {
          self.setErrorState(.unableToOpenBrowser) {
            self.setState { $0.copy(error: nil) }
          }
        }
      } catch {
        self.setErrorState(.genericServiceErrorMessage) {
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
  
  private func setErrorState(
    _ desc: LocalizableKey,
    cancelAction: @escaping () -> ()
  ) {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: desc,
          cancelAction: cancelAction,
          action: { Task { await self.initiate() } }
        )
      )
    }
  }
}
