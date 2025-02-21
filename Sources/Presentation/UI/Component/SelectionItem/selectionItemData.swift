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

struct selectionItemData: Identifiable {
  let id: String
  let overlineText: String?
  let mainText: String?
  let subtitle: String?
  let actionText: String?
  let leadingIcon: (text: String, backgroundColor: Color)?
  let trailingIcon: Image?
  let trailingIconTint: Color?
  let enabled: Bool

  init(
    id: String = UUID().uuidString,
    overlineText: String? = nil,
    mainText: String? = nil,
    subtitle: String? = nil,
    actionText: String? = nil,
    leadingIcon: (text: String, backgroundColor: Color)? = nil,
    trailingIcon: Image? = nil,
    trailingIconTint: Color? = nil,
    enabled: Bool = true
  ) {
    self.id = id
    self.overlineText = overlineText
    self.mainText = mainText
    self.subtitle = subtitle
    self.actionText = actionText
    self.leadingIcon = leadingIcon
    self.trailingIcon = trailingIcon
    self.trailingIconTint = trailingIconTint
    self.enabled = enabled
  }
}
