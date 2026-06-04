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
import SwiftUI
import UIKit

public protocol ColorManagerProtocol: Sendable {

  var black: Color { get }
  var white: Color { get }

  var success: Color { get }
  var successBackground: Color { get }
  var groupedBackground: Color { get }

  var primaryLabel: Color { get }
  var secondaryLabel: Color { get }
  var background: Color { get }
  var accent: Color { get }
}

final class ColorManager: ColorManagerProtocol {

  let bundle: Bundle

  private enum BrandColor: String {
    case success
    case successBackground
    case groupedBackground
  }

  private enum SemanticColor {
    case primaryLabel
    case secondaryLabel
    case background
    case accent
  }

  var black: Color {
    catalogColor(named: "black") ?? .black
  }

  var white: Color {
    catalogColor(named: "white") ?? .white
  }

  var success: Color { brandColor(.success) }
  var successBackground: Color { brandColor(.successBackground) }
  var groupedBackground: Color { brandColor(.groupedBackground) }

  var primaryLabel: Color { semanticColor(.primaryLabel) }
  var secondaryLabel: Color { semanticColor(.secondaryLabel) }
  var background: Color { semanticColor(.background) }
  var accent: Color { semanticColor(.accent) }

  init(bundle: Bundle = .module) {
    self.bundle = bundle
  }

  private func uiColor(_ color: UIColor) -> Color {
    Color(uiColor: color)
  }

  private func catalogColor(named name: String) -> Color? {
    guard let uiColor = UIColor(named: name, in: bundle, compatibleWith: nil) else {
      return nil
    }
    return Color(uiColor: uiColor)
  }

  private func brandColor(_ brand: BrandColor) -> Color {
    Color(brand.rawValue, bundle: bundle)
  }

  private func semanticColor(_ semantic: SemanticColor) -> Color {
    let name: String
    let fallback: Color

    switch semantic {
    case .primaryLabel:
      name = "primaryLabel"
      fallback = uiColor(.label)
    case .secondaryLabel:
      name = "secondaryLabel"
      fallback = uiColor(.secondaryLabel)
    case .background:
      name = "background"
      fallback = uiColor(.systemBackground)
    case .accent:
      name = "accent"
      fallback = uiColor(.systemBlue)
    }

    return catalogColor(named: name) ?? fallback
  }
}
