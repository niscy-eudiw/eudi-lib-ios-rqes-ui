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

struct ContentHeaderConfig {
  let appIconAndTextData: AppIconAndTextData
  let description: String?
  let descriptionTextConfig: TextConfig?
  let relyingPartyData: RelyingPartyData?

  init(
    appIconAndTextData: AppIconAndTextData,
    description: String? = nil,
    descriptionTextConfig: TextConfig? = nil,
    relyingPartyData: RelyingPartyData? = nil
  ) {
    self.appIconAndTextData = appIconAndTextData
    self.description = description
    self.descriptionTextConfig = descriptionTextConfig
    self.relyingPartyData = relyingPartyData
  }
}

struct TextConfig {
  let font: Font
  let color: Color
  let textAlign: TextAlignment
  let maxLines: Int
  let fontWeight: Font.Weight?

  init(
    font: Font,
    color: Color = Theme.shared.color.onSurface,
    textAlign: TextAlignment = .center,
    maxLines: Int = 2,
    fontWeight: Font.Weight? = nil
  ) {
    self.font = font
    self.color = color
    self.fontWeight = fontWeight
    self.textAlign = textAlign
    self.maxLines = maxLines
  }
}

struct ContentHeader: View {
  private let config: ContentHeaderConfig

  init(config: ContentHeaderConfig) {
    self.config = config
  }

  var body: some View {
    VStack(alignment: .center, spacing: SPACING_MEDIUM) {
      AppIconAndText(
        appIconAndTextData: config.appIconAndTextData
      )

      if let description = config.description {
        WrapText(
          text: description,
          textConfig: config.descriptionTextConfig ?? TextConfig(
            font: Theme.shared.font.bodyLarge.font,
            color: Theme.shared.color.onSurface,
            textAlign: .center,
            maxLines: 2,
            fontWeight: nil
          )
        )
        .padding(.vertical, SPACING_SMALL)
      }

      if let relyingPartyData = config.relyingPartyData {
        RelyingParty(relyingPartyData: relyingPartyData)
          .padding(.vertical, SPACING_SMALL)
      }
    }
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  ContentHeader(
    config: ContentHeaderConfig(
      appIconAndTextData: AppIconAndTextData(
        appIcon: Image(.euWalletLogo),
        appText: Image(.eudiTextLogo)
      ),
      description: "You have successfully signed your document.",
      descriptionTextConfig: nil,
      relyingPartyData: RelyingPartyData(
        isVerified: true,
        name: "Relying Party",
        nameTextConfig: nil
      )
    )
  )
  .padding()
}
