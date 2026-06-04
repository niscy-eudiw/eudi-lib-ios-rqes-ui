/*
 * Copyright (c) 2026 European Commission
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
import Foundation
import CoreText

extension Bundle {
  static var assetsBundle: Bundle {
    .module
  }

  /// Registers every .ttf and .otf font file found in the module bundle with
  /// Core Text so they can be used via `Font.custom` or `UIFont(name:size:)`.
  ///
  /// Called from `TypographyManager` initialization. Core Text deduplicates
  /// registrations, so calling this multiple times is safe.
  ///
  /// Member states only need to drop new font files into
  /// `Sources/Resources/` and map PostScript names in `RQESFontConfig.plist`.
  static func registerModuleFonts() {
    ["ttf", "otf"].forEach { ext in
      assetsBundle
        .urls(forResourcesWithExtension: ext, subdirectory: nil)?
        .forEach { url in
          CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
  }
}
