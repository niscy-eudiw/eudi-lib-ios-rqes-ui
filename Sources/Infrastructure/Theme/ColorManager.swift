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

public protocol ColorManagerProtocol: Sendable {
  var background: Color { get }
  var primaryVariant: Color { get }
  var error: Color { get }
  var textPrimaryDark: Color { get }
  var onSurface: Color { get }
  var onSurfaceVariant: Color { get }
  var primaryMain: Color { get }
  var success: Color { get }
  var successVariant: Color { get }
  var warning: Color { get }
  var secondary: Color { get }
  var onPrimary: Color { get }
}

final class ColorManager: ColorManagerProtocol {
  var error: Color {
    Color("Error", bundle: .module)
  }

  var textPrimaryDark: Color {
    Color("TextPrimaryDark", bundle: .module)
  }

  var onSurface: Color {
    Color("OnSurface", bundle: .module)
  }

  var onSurfaceVariant: Color {
    Color("OnSurfaceVariant", bundle: .module)
  }

  var primaryMain: Color {
    Color("PrimaryMain", bundle: .module)
  }

  var success: Color{
    Color("Success", bundle: .module)
  }

  var successVariant: Color {
    Color("SuccessVariant", bundle: .module)
  }

  var warning: Color{
    Color("Warning", bundle: .module)
  }

  var background: Color {
    Color("Background", bundle: .module)
  }

  var primaryVariant: Color {
    Color("PrimaryVariant", bundle: .module)
  }

  var secondary: Color {
    Color("Secondary", bundle: .module)
  }

  var onPrimary: Color {
    Color("OnPrimary", bundle: .module)
  }
}
