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

typealias Theme = ThemeManager

final class ThemeManager: Sendable {

  nonisolated(unsafe) static var shared: ThemeProtocol = AppTheme()

  static func config(with theme: ThemeProtocol) {
    self.shared = theme
  }
}

public protocol ThemeProtocol: Sendable {
  var color: ColorManagerProtocol { get }
  var font: TypographyManagerProtocol { get }
}

extension ThemeProtocol {
  var color: ColorManagerProtocol {
    ColorManager()
  }

  var font: TypographyManagerProtocol {
    TypographyManager()
  }
}

final class AppTheme: ThemeProtocol {
  init() {}
}
