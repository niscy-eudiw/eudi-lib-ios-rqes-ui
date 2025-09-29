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

struct RelyingPartyData {
  public let isVerified: Bool
  public let name: String?
  public let nameTextConfig: TextConfig?
  public let description: String?
  public let descriptionTextConfig: TextConfig?

  init(
    isVerified: Bool,
    name: String? = nil,
    nameTextConfig: TextConfig? = nil,
    description: String? = nil,
    descriptionTextConfig: TextConfig? = nil
  ) {
    self.isVerified = isVerified
    self.name = name
    self.nameTextConfig = nameTextConfig
    self.description = description
    self.descriptionTextConfig = descriptionTextConfig
  }
}

struct RelyingPartyView: View {
  private let relyingPartyData: RelyingPartyData

  init(relyingPartyData: RelyingPartyData) {
    self.relyingPartyData = relyingPartyData
  }

  var body: some View {
    VStack(alignment: .center, spacing: SPACING_SMALL) {
      if let name = relyingPartyData.name {
        WrapTextView(
          text: name,
          textConfig: relyingPartyData.nameTextConfig ?? TextConfig(
            font: EudiRQESUi.getTheme().font.bodyLarge.font,
            color: EudiRQESUi.getTheme().color.onSurface,
            textAlign: .center,
            maxLines: 1,
            fontWeight: .semibold
          )
        )
        .if(relyingPartyData.isVerified) {
          $0.leftImage(
            image: Image(.verified),
            spacing: 5,
            size: 20
          )
        }
      }

      if let description = relyingPartyData.description {
        WrapTextView(
          text: description,
          textConfig: relyingPartyData.descriptionTextConfig ?? TextConfig(
            font: EudiRQESUi.getTheme().font.bodyMedium.font,
            color: EudiRQESUi.getTheme().color.onSurface,
            textAlign: .center,
            maxLines: 2,
            fontWeight: nil
          )
        )
      }
    }
    .frame(maxWidth: .infinity, alignment: .center)
  }
}
