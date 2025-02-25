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
    leadingIconTint: Color = Theme.shared.color.black,
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
