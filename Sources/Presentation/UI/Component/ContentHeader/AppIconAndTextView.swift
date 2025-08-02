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

struct AppIconAndTextData {
  public let appIcon: Image
  public let appText: Image
  public let appIconSize: CGFloat
  public let appTextSize: CGFloat

  init(
    appIcon: Image,
    appText: Image,
    appIconSize: CGFloat = 60,
    appTextSize: CGFloat = 60
  ) {
    self.appIcon = appIcon
    self.appText = appText
    self.appIconSize = appIconSize
    self.appTextSize = appTextSize
  }
}

struct AppIconAndTextView: View {
  private let appIconAndTextData: AppIconAndTextData

  init(
    appIconAndTextData: AppIconAndTextData
  ) {
    self.appIconAndTextData = appIconAndTextData
  }

  var body: some View {
    HStack(spacing: SPACING_SMALL) {
      appIconAndTextData.appIcon
        .resizable()
        .scaledToFit()
        .frame(width: appIconAndTextData.appIconSize, height: appIconAndTextData.appIconSize)
      appIconAndTextData.appText
        .resizable()
        .scaledToFit()
        .frame(width: appIconAndTextData.appTextSize, height: appIconAndTextData.appTextSize)
    }
    .frame(maxWidth: .infinity, alignment: .center)
  }
}
