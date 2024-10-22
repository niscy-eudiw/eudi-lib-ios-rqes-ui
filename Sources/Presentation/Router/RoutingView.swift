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

struct RoutingView<T: RouterGraph, Content: View>: View {
  @ObservedObject var router: T
  public let content: Content
  public var detents: Set<PresentationDetent>
  public let indicator: Visibility
  
  public init(router: T, @ViewBuilder content: @escaping () -> Content, detents: Set<PresentationDetent> = [.large], indicator: Visibility = .hidden) {
    self.router = router
    self.content = content()
    self.detents = detents
    self.indicator = indicator
  }
  
  public var body: some View {
    if #available(iOS 16.0, *) {
      NavigationStack(path: $router.path) {
        content
          .navigationDestination(for: T.Route.self) { route in
            router.view(for: route)
          }
      }
    }
  }
}
