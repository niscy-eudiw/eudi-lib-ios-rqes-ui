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

@available(iOS 13.0, *)
final class Router: RouterGraph {
  
  @Published var path: NavigationPath = NavigationPath()
  
  enum RQESRoute: Hashable, Identifiable{
    case documentSelection
    case homePostDetails(postID: Int)
    case homeCreatePost
    
    var id: String {
      switch self {
      default:
        return ""
      }
    }
  }
  
  func view(for route: RQESRoute) -> AnyView {
    switch route {
    default:
      return Text("").eraseToAnyView()
    }
  }
}
