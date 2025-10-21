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
@_exported import SwiftUI
@_exported import Combine
@_exported import Copyable
import Observation

protocol ViewState {}

@MainActor
@Observable
class ViewModel<Router: RouterGraph, UiState: ViewState> {
  
  private(set) var viewState: UiState

  @ObservationIgnored
  let router: Router
  
  init(router: Router, initialState: UiState) {
    self.router = router
    self.viewState = initialState
  }
  
  func setState(_ reducer: (UiState) -> UiState) {
    self.viewState = reducer(viewState)
  }
  
  func onPause() {
    Task {
      await EudiRQESUi.requireInstance().pause()
    }
  }
  
  func onCancel() {
    Task {
      await EudiRQESUi.requireInstance().cancel()
    }
  }
}
