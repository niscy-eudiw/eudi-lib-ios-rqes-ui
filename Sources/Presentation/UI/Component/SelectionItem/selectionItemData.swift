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

struct SelectionItemData: Identifiable {
  let id: String
  let overlineText: LocalizableKey?
  let mainText: LocalizableKey?
  let subtitle: LocalizableKey?
  let actionText: LocalizableKey?
  let leadingIcon: Image?
  let leadingIconTint: Color
  let trailingIcon: Image?
  let trailingIconTint: Color
  let enabled: Bool
  let action: (() -> Void)?

  init(
    id: String = UUID().uuidString,
    overlineText: LocalizableKey? = nil,
    mainText: LocalizableKey? = nil,
    subtitle: LocalizableKey? = nil,
    actionText: LocalizableKey? = nil,
    leadingIcon: Image? = nil,
    leadingIconTint: Color = try! EudiRQESUi.getTheme().color.black,
    trailingIcon: Image? = Image(systemName: "chevron.right"),
    trailingIconTint: Color = Color.accentColor,
    enabled: Bool = true,
    action: (() -> Void)? = nil
  ) {
    self.id = id
    self.overlineText = overlineText
    self.mainText = mainText
    self.subtitle = subtitle
    self.actionText = actionText
    self.leadingIcon = leadingIcon
    self.leadingIconTint = leadingIconTint
    self.trailingIcon = trailingIcon
    self.trailingIconTint = trailingIconTint
    self.enabled = enabled
    self.action = action
  }
}
