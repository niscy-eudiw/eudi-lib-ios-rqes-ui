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
import Foundation
import SwiftUI

protocol RouterGraph: ObservableObject, Sendable {
  
  var path: NavigationPath { get set }
  
  @MainActor func navigateTo(_ appRoute: Route)
  @MainActor func pop()
  @MainActor func navigateToRoot()
  @MainActor func view(for route: Route) -> AnyView
  @MainActor func nextView(for state: EudiRQESUi.State) throws -> UIViewController
  @MainActor func clear()
}

final class RouterGraphImpl: RouterGraph, @unchecked Sendable {
  
  @Published var path: NavigationPath = NavigationPath()
  
  init() {}
  
  func view(for route: Route) -> AnyView {
    switch route {
    case .documentSelection:
      DocumentSelectionView(
        with: DocumentSelectionViewModel(
          router: self,
          interactor: DIGraph.shared.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .serviceSelection:
      ServiceSelectionView(
        with: ServiceSelectionViewModel(
          router: self,
          interactor: DIGraph.shared.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .credentialSelection:
      CredentialSelectionView(
        with: CredentialSelectionViewModel(
          router: self,
          interactor: DIGraph.shared.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .signedDocument:
      SignedDocumentView(
        with: SignedDocumentViewModel(
          router: self,
          interactor: DIGraph.shared.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .viewDocument(let isSigned):
      DocumentViewer(
        with: DocumentViewModel(
          router: self,
          interactor: DIGraph.shared.resolver.force(
            RQESInteractor.self
          )
        ),
        isSigned: isSigned
      )
      .eraseToAnyView()
    }
  }
  
  func nextView(for state: EudiRQESUi.State) throws -> UIViewController {
    
    guard state != .none else {
      throw EudiRQESUiError.invalidState(state.id)
    }
    
    return ContainerViewController(
      rootView: ContainerView(
        router: self
      ) { _ in
        switch state {
        case .none:
          EmptyView()
        case .initial:
          DocumentSelectionView(
            with: DocumentSelectionViewModel(
              router: self,
              interactor: DIGraph.shared.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .rssps:
          ServiceSelectionView(
            with: ServiceSelectionViewModel(
              router: self,
              interactor: DIGraph.shared.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .credentials:
          DocumentSelectionView(
            with: DocumentSelectionViewModel(
              router: self,
              interactor: DIGraph.shared.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .sign:
          SignedDocumentView(
            with: SignedDocumentViewModel(
              router: self,
              interactor: DIGraph.shared.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .view:
          DocumentViewer(
            with: DocumentViewModel(
              router: self,
              interactor: DIGraph.shared.resolver.force(
                RQESInteractor.self
              )
            )
          )
        }
      }
    )
  }
  
  func navigateTo(_ appRoute: Route) {
    path.append(appRoute)
  }
  
  func pop() {
    path.removeLast()
  }
  
  func navigateToRoot() {
    path.removeLast(path.count)
  }
  
  func clear() {
    if !path.isEmpty{
      path = NavigationPath()
    }
  }
}

enum Route: Hashable, Identifiable, Equatable {
  
  case documentSelection
  case serviceSelection
  case credentialSelection
  case signedDocument
  case viewDocument(Bool)
  
  var id: String {
    switch self {
    case .documentSelection:
      return "documentSelection"
    case .serviceSelection:
      return "serviceSelection"
    case .credentialSelection:
      return "credentialSelection"
    case .signedDocument:
      return "signedDocument"
    case .viewDocument:
      return "viewDocument"
    }
  }
  
  public static func == (lhs: Route, rhs: Route) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    switch self {
    case .documentSelection:
      hasher.combine("documentSelection")
    case .serviceSelection:
      hasher.combine("serviceSelection")
    case .credentialSelection:
      hasher.combine("credentialSelection")
    case .signedDocument:
      hasher.combine("signedDocument")
    case .viewDocument:
      hasher.combine("viewDocument")
    }
  }
}
