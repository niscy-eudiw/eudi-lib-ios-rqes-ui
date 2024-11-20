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
  let isLoading: Bool
  let services: [QTSPData]
  let error: ContentErrorView.Config?
}

class ServiceSelectionViewModel<Router: RouterGraph>: ViewModel<Router, ServiceSelectionState> {

  private let interactor: RQESInteractor
  @Published var selectedItem: QTSPData?

  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: ServiceSelectionState(
        isLoading: true,
        services: [],
        error: nil
      )
    )
  }

  func initiate() {
    Task {
      let services = await interactor.getQTSps()

      if let services {
        setState {
          $0.copy(
            isLoading: false,
            services: services
          )
          .copy(error: nil)
        }
      } else {
        setErrorState()
      }
    }
  }

  func selectQTSP(_ qtsp: QTSPData) {
    Task {
      await interactor.updateQTSP(qtsp)
    }
  }

  func nextStep() {
    onPause()
    openAuthorization()
  }

  func openAuthorization() {
    Task {
      do {
        if let selectedItem {
          try await interactor.createRQESService(selectedItem)
        } else {
          setErrorState()
        }
        let authorizationUrl = try await interactor.openAuthrorizationURL()

        await UIApplication.shared.openURLIfPossible(authorizationUrl) {
          self.setErrorState()
        }
      } catch {
        setErrorState()
      }
    }
  }

  private func setErrorState() {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: .genericErrorQtspNotFound,
          cancelAction: { self.setState { $0.copy(error: nil) } },
          action: initiate
        )
      )
    }
  }
}
