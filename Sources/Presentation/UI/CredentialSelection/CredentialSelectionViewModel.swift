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
  let credentials: [CertificateData]
}

final class CredentialSelectionViewModel<Router: RouterGraph>: ViewModel<Router, CredentialSelectionState> {

  private let interactor: QTSPInteractor
  @Published var document: DocumentData?
  @Published var qtspName: String?

  init(
    router: Router,
    interactor: QTSPInteractor = QTSPInteractorImpl(),
    initialState: CredentialSelectionState = .init(credentials: [])
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: initialState
    )
  }

  @MainActor
  func fetchCredentials() {
    Task {
      do {
        let credentials = try await interactor.qtspCertificates(qtspCertificateEndpoint: URL(string: "uri")!)
        self.setState {
          $0.copy(credentials: credentials)
        }
      } catch {

      }
    }
  }

  func setCertificate(_ certificate: String? = nil) {
    Task {
      try? await EudiRQESUi.instance().updateCertificate(with: certificate)
    }
  }

  func getDocument() {
    Task {
      document = try? await EudiRQESUi.instance().selection.document
      qtspName = try? await EudiRQESUi.instance().selection.qtsp?.qtspName
    }
  }
}
