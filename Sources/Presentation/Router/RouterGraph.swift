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
  
  associatedtype Route: Hashable & Identifiable
  
  var path: NavigationPath { get set }
  
  @MainActor func navigateTo(_ appRoute: Route)
  @MainActor func pop()
  @MainActor func navigateToRoot()
  @MainActor func view(for route: Route) -> AnyView
  @MainActor func nextView(for state: EudiRQESUi.State) throws -> UIViewController
  @MainActor func clear()
}

extension RouterGraph {
  
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

final class RouterGraphImpl: RouterGraph, @unchecked Sendable {
  
  typealias Route = RouteTable
  
  @Published var path: NavigationPath = NavigationPath()
  
  init() {}
  
  enum RouteTable: Hashable, Identifiable, Equatable {
    case documentSelection(document: URL, services: [URL])
    case serviceSelection(services: [URL])
    case credentialSelection
    case signedDocument(title: String, contents: String)
    case viewDocument(DocumentSource)
    case certificateSelection(any EudiRQESUiConfig)
    
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
      case .certificateSelection:
        return "certificateSelection"
      }
    }
    
    public static func == (lhs: RouteTable, rhs: RouteTable) -> Bool {
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
      case .certificateSelection:
        hasher.combine("certificateSelection")
      }
    }
  }
  
  func view(for route: Route) -> AnyView {
    switch route {
    case .documentSelection(let document, let services):
      DocumentSelectionView(
        router: self,
        document: document,
        services: services
      )
      .eraseToAnyView()
    case .serviceSelection(let services):
      ServiceSelectionView(
        router: self,
        services: services
      )
      .eraseToAnyView()
    case .credentialSelection:
      CredentialSelectionView(
        router: self
      )
      .eraseToAnyView()
    case .signedDocument(let name, let contents):
      SignedDocumentView(
        router: self,
        initialState: .init(
          name: name,
          contents: contents
        )
      )
      .eraseToAnyView()
    case .viewDocument(let source):
      DocumentViewer(
        router: self,
        source: source
      )
      .eraseToAnyView()
    case .certificateSelection:
      fatalError("TODO")
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
        case .initial(
          let document,
          let config
        ):
          DocumentSelectionView(
            router: self,
            document: document,
            services: config.rssps
          )
        case .rssps(let services):
          ServiceSelectionView(
            router: self,
            services: services
          )
        case .credentials:
          CredentialSelectionView(
            router: self
          )
        case .sign(let name, let contents):
          SignedDocumentView(
            router: self,
            initialState: .init(
              name: name,
              contents: contents
            )
          )
        case .view(let source):
          DocumentViewer(
            router: self,
            source: source
          )
        }
      }
    )
  }
}
