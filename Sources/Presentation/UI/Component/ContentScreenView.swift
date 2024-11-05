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

public struct ContentScreenView<Content: View>: View {

  let content: Content
  let padding: CGFloat
  let spacing: CGFloat
  let background: Color

  public init(
    padding: CGFloat = 16,
    canScroll: Bool = false,
    spacing: CGFloat = 0,
    background: Color = .white,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.padding = padding
    self.spacing = spacing
    self.background = background
  }

  public var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: spacing) {
        content
      }
      .padding([.all], padding)
    }
    .background(background)
    .fastenDynamicType()
  }
}
