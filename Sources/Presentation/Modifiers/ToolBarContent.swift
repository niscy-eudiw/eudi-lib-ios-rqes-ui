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

struct Action: Identifiable {
  let id = UUID()
  let title: String?
  let image: Image?
  let callback: (() -> Void)?
  
  init(
    title: String? = nil,
    image: Image? = nil,
    callback: (() -> Void)? = nil
  ) {
    self.title = title
    self.image = image
    self.callback = callback
  }
}

struct ToolBarContent: ToolbarContent {
  
  private let trailingActions: [Action]?
  private let leadingActions: [Action]?
  
  init(
    trailingActions: [Action]? = nil,
    leadingActions: [Action]? = nil
  ) {
    self.trailingActions = trailingActions
    self.leadingActions = leadingActions
  }
  
  var body: some ToolbarContent {
    if let leadingActions {
      ToolbarItemGroup(placement: .topBarLeading) {
        ForEach(leadingActions, id: \.id) { action in
          ActionView(action: action)
        }
      }
    }
    if let trailingActions {
      ToolbarItemGroup(placement: .topBarTrailing) {
        ForEach(trailingActions, id: \.id) { action in
          ActionView(action: action)
        }
      }
    }
  }
}

private struct ActionView: View {
  let action: Action
  
  var body: some View {
    Group {
      if let callback = action.callback {
        Button(action: callback) {
          content
        }
      } else {
        content
      }
    }
  }
  
  @ViewBuilder
  private var content: some View {
    if let title = action.title {
      Text(title)
    }
    if let image = action.image {
      image
    }
  }
}

#Preview {
  NavigationStack {
    Text("Hello, World!")
      .toolbar {
        ToolBarContent(
          trailingActions: [
            Action(
              title: "State",
              callback: {}
            ),
            Action(
              title: "Proceed",
              callback: {}
            )
          ],
          leadingActions: [
            Action(
              title: "Cancel",
              callback: {}
            )
          ]
        )
      }
  }
}
