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

  @MainActor
  func fetchCredentials() {
    Task {
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
          }
        case .failure:
          setErrorState()
        }
      } catch {
        setErrorState()
      }
    }
  }

  func setCertificate(_ certificate: CredentialDataUIModel? = nil) {
    Task {
      if let credential = viewState.credentialInfos.first(where: { $0.credentialID == certificate?.id}) {
        try? await EudiRQESUi.instance().updateCertificate(with: credential)
      } else {
        setErrorState()
      }
    }
  }

  func getDocument() {
    Task {
      let documentName = await interactor.getCurrentSelection()?.document?.documentName

      if let documentName {
        setState {
          $0
            .copy(
              isLoading: false,
              documentName: documentName
            )
        }
      } else {
        setErrorState()
      }
    }
  }

  func openAuthorization() {
    Task {
      do {
        try await interactor.openCredentialAuthrorizationURL()
      } catch {
        setErrorState()
      }
    }
  }

  private func setErrorState() {
    setState {
      $0
        .copy(
          isLoading: false,
          error: ContentErrorView.Config(
            title: .genericErrorMessage,
            description: .genericErrorDocumentNotFound,
            cancelAction: fetchCredentials,
            action: fetchCredentials
          )
        )
    }
  }
}
