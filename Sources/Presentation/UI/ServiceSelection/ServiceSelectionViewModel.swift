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
struct ServiceSelectionState: ViewState {
  let services: [QTSPData]
  let error: ContentErrorView.Config?
}

class ServiceSelectionViewModel<Router: RouterGraph>: ViewModel<Router, ServiceSelectionState> {

  private let interactor: RQESInteractor

  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: ServiceSelectionState(
        services: [],
        error: nil
      )
    )
  }

  func initiate() {
    Task {
      let services = try? await interactor.getQTSps()

      if let services {
        setState {
          $0
            .copy(
              services: services
            )
        }
      } else {
        setState {
          $0
            .copy(
              error: ContentErrorView.Config(
                title: .genericErrorMessage,
                description: .genericErrorQtspNotFound,
                cancelAction: {}(),
                action: initiate
              )
            )
        }
      }
    }
  }

  func selectQTSP(_ qtsp: QTSPData? = nil) {
    Task {
      try? await EudiRQESUi.instance().updateQTSP(with: qtsp)
    }
  }

  func selectCredential() {
    if let router = self.router as? RouterGraphImpl {
      router.navigateTo(
        .credentialSelection
      )
    }
  }
}
