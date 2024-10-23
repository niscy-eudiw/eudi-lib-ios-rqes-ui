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

final class RouterGraphImpl: RouterGraph {
  
  typealias Route = RouteTable
  
  @Published var path: NavigationPath = NavigationPath()
  
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
}
