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
            font: Theme.shared.font.bodyLarge.font,
            color: Theme.shared.color.onSurface,
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
            font: Theme.shared.font.bodyMedium.font,
            color: Theme.shared.color.onSurface,
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
