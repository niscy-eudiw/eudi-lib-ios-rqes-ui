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
    color: Color = try! EudiRQESUi.getTheme().color.onSurface,
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
      AppIconAndTextView(
        appIconAndTextData: config.appIconAndTextData
      )

      if let description = config.description {
        WrapTextView(
          text: description,
          textConfig: config.descriptionTextConfig ?? TextConfig(
            font: try! EudiRQESUi.getTheme().font.bodyLarge.font,
            color: try! EudiRQESUi.getTheme().color.onSurface,
            textAlign: .center,
            maxLines: 2,
            fontWeight: nil
          )
        )
        .padding(.vertical, SPACING_SMALL)
      }

      if let relyingPartyData = config.relyingPartyData {
        RelyingPartyView(relyingPartyData: relyingPartyData)
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
