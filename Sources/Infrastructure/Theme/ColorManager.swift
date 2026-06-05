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

  // MARK: - System palette

  var black: Color { get }
  var white: Color { get }

  // MARK: - Brand

  var success: Color { get }
  var successBackground: Color { get }
  var groupedBackground: Color { get }

  // MARK: - Semantic (UIKit)

  var primaryLabel: Color { get }
  var secondaryLabel: Color { get }
  var background: Color { get }
  var accent: Color { get }
}

final class ColorManager: ColorManagerProtocol {

  let bundle: Bundle

  enum SystemColors: String, CaseIterable {
    case black
    case white
  }

  enum BrandColors: String, CaseIterable {
    case success
    case successBackground
    case groupedBackground
  }

  enum SemanticColors: String, CaseIterable {
    case primaryLabel
    case secondaryLabel
    case background
    case accent
  }

  // MARK: - System palette

  var black: Color { color(for: .black) }
  var white: Color { color(for: .white) }

  // MARK: - Brand

  var success: Color { color(for: .success) }
  var successBackground: Color { color(for: .successBackground) }
  var groupedBackground: Color { color(for: .groupedBackground) }

  // MARK: - Semantic

  var primaryLabel: Color { color(for: .primaryLabel) }
  var secondaryLabel: Color { color(for: .secondaryLabel) }
  var background: Color { color(for: .background) }
  var accent: Color { color(for: .accent) }

  // MARK: - Lifecycle

  init(bundle: Bundle = .module) {
    self.bundle = bundle
  }

  // MARK: - Resolution

  private func uiColor(_ color: UIColor) -> Color {
    Color(uiColor: color)
  }

  /// Tries to load the named color from the asset catalog first.
  /// Returns `nil` when no entry with that name exists, allowing callers to fall back.
  private func catalogColor(named name: String) -> Color? {
    guard let uiColor = UIColor(named: name, in: bundle, compatibleWith: nil) else {
      return nil
    }
    return Color(uiColor: uiColor)
  }

  /// Resolves a system color.
  /// When a color named after the enum case exists in the asset catalog it takes
  /// precedence over the SwiftUI system color, so member-state themes only need
  /// to add an entry with the matching name (e.g. "black") to the Color catalog.
  func color(for system: SystemColors) -> Color {
    if let catalogColor = catalogColor(named: system.rawValue) {
      return catalogColor
    }
    switch system {
    case .black: return .black
    case .white: return .white
    }
  }

  func color(for brand: BrandColors) -> Color {
    Color(brand.rawValue, bundle: bundle)
  }

  /// Resolves a semantic color.
  /// When a color named after the enum case exists in the asset catalog it takes
  /// precedence over the UIKit adaptive color, so member-state themes only need
  /// to add an entry with the matching name (e.g. "primaryLabel") to the Color catalog.
  func color(for semantic: SemanticColors) -> Color {
    if let catalogColor = catalogColor(named: semantic.rawValue) {
      return catalogColor
    }
    switch semantic {
    case .primaryLabel: return uiColor(.label)
    case .secondaryLabel: return uiColor(.secondaryLabel)
    case .background: return uiColor(.systemBackground)
    case .accent: return uiColor(.systemBlue)
    }
  }
}

struct ColorDescr: Identifiable {
  var id = UUID()
  var color: Color
  var description: String
}

struct ColorsPreview: View {
  private let colorManager = ColorManager(bundle: .module)

  func systemColors() -> [ColorDescr] {
    ColorManager.SystemColors.allCases.map { colorEnum in
      ColorDescr(
        color: colorManager.color(for: colorEnum),
        description: colorEnum.rawValue
      )
    }
  }

  func brandColors() -> [ColorDescr] {
    ColorManager.BrandColors.allCases.map { colorEnum in
      ColorDescr(
        color: colorManager.color(for: colorEnum),
        description: colorEnum.rawValue
      )
    }
  }

  func semanticColors() -> [ColorDescr] {
    ColorManager.SemanticColors.allCases.map { colorEnum in
      ColorDescr(
        color: colorManager.color(for: colorEnum),
        description: colorEnum.rawValue
      )
    }
  }

  var body: some View {
    ScrollView {
      VStack {
        Text("System colors")
          .font(.title)
        ForEach(systemColors()) { item in
          ZStack {
            item.color
            Text(item.description).foregroundColor(Color.black)
          }
        }
        Text("Brand colors")
          .font(.title)
        ForEach(brandColors()) { item in
          ZStack {
            item.color
            Text(item.description).foregroundColor(Color.black)
          }
        }
        Text("Semantic colors")
          .font(.title)
        ForEach(semanticColors()) { item in
          ZStack {
            item.color
            Text(item.description).foregroundColor(Color.black)
          }
        }
      }
    }
  }
}

#Preview {
  ColorsPreview()
}
