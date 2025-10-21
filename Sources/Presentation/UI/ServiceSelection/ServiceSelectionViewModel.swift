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
import Observation

@Copyable
struct ServiceSelectionState: ViewState {
  let isLoading: Bool
  let services: [QTSPData]
  let error: ContentErrorView.Config?
}

@Observable
final class ServiceSelectionViewModel<Router: RouterGraph>: ViewModel<Router, ServiceSelectionState> {

  @ObservationIgnored
  private let interactor: RQESInteractor

  var selectedItem: QTSPData?
  
  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: ServiceSelectionState(
        isLoading: false,
        services: [],
        error: nil
      )
    )
  }
  
  func initiate() async {
    
    let services = await interactor.getQTSps()
    
    if !services.isEmpty {
      setState {
        $0.copy(
          services: services
        )
        .copy(error: nil)
      }
    } else {
      setErrorState(.genericErrorQtspNotFound) {
        self.router.pop()
      }
    }
  }
  
  func nextStep() {
    openAuthorization()
  }
  
  func openAuthorization() {
    Task {
      
      setState {
        $0.copy(isLoading: true).copy(error: nil)
      }
      
      do {
        if let selectedItem {
          try await interactor.createRQESService(selectedItem)
        } else {
          throw EudiRQESUiError.noRQESServiceProvided
        }
        
        let authorizationUrl = try await interactor.openAuthrorizationURL()
        
        await interactor.updateQTSP(selectedItem)
        
        self.onPause()
        
        await UIApplication.shared.openURLIfPossible(authorizationUrl) {
          self.setErrorState(.unableToOpenBrowser) {
            self.setState { $0.copy(error: nil) }
          }
        }
      } catch {
        setErrorState(.genericServiceErrorMessage) {
          self.router.pop()
        }
      }
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
