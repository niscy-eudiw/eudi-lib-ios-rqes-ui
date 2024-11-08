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

struct ContentScreenView<Content: View>: View {

  private let content: Content
  private let padding: CGFloat
  private let spacing: CGFloat
  private let background: Color
  private let title: String
  private let toolbarContent: ToolBarContent?

  init(
    padding: CGFloat = 16,
    canScroll: Bool = false,
    spacing: CGFloat = 0,
    background: Color = .white,
    title: String,
    toolbarContent: ToolBarContent? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.padding = padding
    self.spacing = spacing
    self.background = background
    self.title = title
    self.toolbarContent = toolbarContent
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: spacing) {
        content
      }
      .padding([.all], padding)
    }
    .navigationTitle(title)
    .navigationBarTitleDisplayMode(.inline)
    .if(toolbarContent != nil) {
      $0.toolbar {
        toolbarContent
      }
    }
    .background(background)
    .fastenDynamicType()
  }
}
