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

struct WrapButtonView: View {

  private let title: String
  private let onAction: () -> Void
  private let textColor: Color
  private let backgroundColor: Color
  private let cornerRadius: CGFloat
  private let isEnabled: Bool
  private let borderWidth: CGFloat
  private let borderColor: Color
  private let isLoading: Bool

  init(
    style: ButtonViewStyle,
    title: String,
    isLoading: Bool = false,
    isEnabled: Bool = true,
    borderWidth: CGFloat = 0,
    cornerRadius: CGFloat = SPACING_SMALL,
    onAction: @autoclosure @escaping () -> Void
  ) {
    self.title = title
    self.textColor = style.textColor
    self.backgroundColor = style.backgroundColor
    self.isLoading = isLoading
    self.isEnabled = isEnabled
    self.cornerRadius = cornerRadius
    self.borderWidth = style.borderWidth
    self.borderColor = style.borderColor
    self.onAction = onAction
  }

  public var body: some View {
    Button(
      action: { onAction() },
      label: {
        HStack {
          Text(title)
            .font(Theme.shared.font.bodyMedium.font)
            .foregroundColor(textColor)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
          RoundedRectangle(cornerRadius: cornerRadius)
            .stroke(borderColor, lineWidth: borderWidth)
        )
      }
    )
    .if(!isEnabled && !isLoading) {
      $0.opacity(0.5)
    }
    .disabled(isLoading || !isEnabled)
  }
}

#Preview {
  VStack {
    WrapButtonView(
      style: .primary,
      title: "Save",
      onAction: {}()
    )
    WrapButtonView(
      style: .secondary,
      title: "Cancel",
      onAction: {}()
    )
  }
  .padding()
}

#Preview("Dark Mode") {
  VStack {
    WrapButtonView(
      style: .primary,
      title: "Save",
      onAction: {}()
    )
    WrapButtonView(
      style: .secondary,
      title: "Cancel",
      onAction: {}()
    )
  }
  .padding()
  .darkModePreview()
}

enum ButtonViewStyle {
  case primary
  case secondary

  var textColor: Color {
    switch self {
    case .primary:
      Theme.shared.color.onPrimary
    case .secondary:
      Theme.shared.color.primaryMain
    }
  }
  var backgroundColor: Color {
    switch self {
    case .primary:
      Theme.shared.color.primaryMain
    case .secondary:
      Theme.shared.color.onPrimary
    }
  }
  var borderWidth: CGFloat {
    switch self {
    case .primary:
      0
    case .secondary:
      1
    }
  }
  var borderColor: Color {
    switch self {
    case .primary:
        .clear
    case .secondary:
      Theme.shared.color.primaryMain
    }
  }
}

