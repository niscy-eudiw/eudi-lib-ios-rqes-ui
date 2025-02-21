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
          interactor: DIGraph.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .serviceSelection:
      ServiceSelectionView(
        with: ServiceSelectionViewModel(
          router: self,
          interactor: DIGraph.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .credentialSelection:
      CredentialSelectionView(
        with: CredentialSelectionViewModel(
          router: self,
          interactor: DIGraph.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .signedDocument:
      SignedDocumentView(
        with: SignedDocumentViewModel(
          router: self,
          interactor: DIGraph.resolver.force(
            RQESInteractor.self
          )
        )
      )
      .eraseToAnyView()
    case .viewDocument(let isSigned):
      DocumentViewer(
        with: DocumentViewModel(
          router: self,
          interactor: DIGraph.resolver.force(
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
              interactor: DIGraph.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .rssps:
          ServiceSelectionView(
            with: ServiceSelectionViewModel(
              router: self,
              interactor: DIGraph.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .credentials:
          DocumentSelectionView(
            with: DocumentSelectionViewModel(
              router: self,
              interactor: DIGraph.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .sign:
          SignedDocumentView(
            with: SignedDocumentViewModel(
              router: self,
              interactor: DIGraph.resolver.force(
                RQESInteractor.self
              )
            )
          )
        case .view:
          DocumentViewer(
            with: DocumentViewModel(
              router: self,
              interactor: DIGraph.resolver.force(
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
