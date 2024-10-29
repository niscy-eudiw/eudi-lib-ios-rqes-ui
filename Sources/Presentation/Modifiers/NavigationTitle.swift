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

extension View {
  func withNavigationTitle(
    _ title: String,
    trailingAction: Action? = nil,
    leadingAction: Action? = nil
  ) -> some View {
    self.modifier(NavigationTitleModifier(
      title: title,
      trailingAction: trailingAction,
      leadingAction: leadingAction
    ))
  }
}

struct Action: Identifiable {
  let id = UUID()
  let title: String?
  let image: Image?
  let callback: () -> Void

  init(
    title: String? = nil,
    image: Image? = nil,
    callback: @escaping () -> Void
  ) {
    self.title = title
    self.image = image
    self.callback = callback
  }
}

private struct NavigationTitleModifier: ViewModifier {
  private let title: String
  private let trailingAction: Action?
  private let leadingAction: Action?

  init(
    title: String,
    trailingAction: Action?,
    leadingAction: Action?
  ) {
    self.title = title
    self.trailingAction = trailingAction
    self.leadingAction = leadingAction
  }

  func body(content: Content) -> some View {
    content
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        if let leadingAction {
          ToolbarItem(placement: .topBarLeading) {
            Button(action: leadingAction.callback) {
              if let title = leadingAction.title {
                Text(title)
              }
              if let image = leadingAction.image {
                image
              }
            }
          }
        }
        if let trailingAction {
          ToolbarItem(placement: .topBarTrailing) {
            Button(action: trailingAction.callback) {
              if let title = trailingAction.title {
                Text(title)
              }
              if let image = trailingAction.image {
                image
              }
            }
          }
        }
      }
  }
}

#Preview {
  NavigationStack {
    Text("Hello, World!")
      .withNavigationTitle(
        "Confirm Selection",
        trailingAction: Action(
          title: "Save",
          callback: {}
        ),
        leadingAction: Action(
          title: "Cancel",
          callback: {}
        )
      )
  }
}
