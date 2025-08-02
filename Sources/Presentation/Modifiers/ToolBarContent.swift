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
import SwiftUI

struct Action: Identifiable {
  let id = UUID()
  let title: LocalizableKey?
  let image: Image?
  let disabled: Bool
  let callback: (() -> Void)?
  
  init(
    title: LocalizableKey? = nil,
    image: Image? = nil,
    disabled: Bool = false,
    callback: (() -> Void)? = nil
  ) {
    self.title = title
    self.image = image
    self.disabled = disabled
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
          ActionView(
            action: action,
            disabled: action.disabled
          )
        }
      }
    }
    if let trailingActions {
      ToolbarItemGroup(placement: .topBarTrailing) {
        ForEach(trailingActions, id: \.id) { action in
          ActionView(
            action: action,
            disabled: action.disabled
          )
        }
      }
    }
  }
}

private struct ActionView: View {
  
  @Environment(\.localizationController) var localization
  
  let action: Action
  let disabled: Bool
  
  init(action: Action, disabled: Bool) {
    self.action = action
    self.disabled = disabled
  }
  
  var body: some View {
    Group {
      if let callback = action.callback {
        Button(action: callback) {
          content
        }
        .disabled(disabled)
      } else {
        content
      }
    }
  }
  
  @ViewBuilder
  private var content: some View {
    if let title = action.title {
      Text(localization.get(with: title))
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
              title: .state,
              disabled: false,
              callback: {}
            ),
            Action(
              title: .proceed,
              disabled: false,
              callback: {}
            )
          ],
          leadingActions: [
            Action(
              title: .cancel,
              disabled: false,
              callback: {}
            )
          ]
        )
      }
  }
  .environment(\.localizationController, PreviewLocalizationController())
}
