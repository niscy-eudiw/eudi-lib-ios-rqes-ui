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

final class MainRouter: RouterGraph {
  
  typealias Route = RouteTable
  
  @Published var path: NavigationPath = NavigationPath()
  
  enum RouteTable: Hashable, Identifiable {
    case documentSelection(document: URL, services: [URL])
    case serviceSelection(services: [URL])
    case credentialSelection(credntials: [String])
    case signedDocument(String, String)
    case viewDocument(Bool, DocumentSource)
    
    var id: String {
      switch self {
      default:
        return ""
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
    case .credentialSelection(let credentials):
      Text("")
        .eraseToAnyView()
    case .signedDocument(_, _):
      Text("")
        .eraseToAnyView()
    case .viewDocument(let signed, let source):
      DocumentViewer(
        router: self,
        source: source
      )
      .eraseToAnyView()
    }
  }
}
