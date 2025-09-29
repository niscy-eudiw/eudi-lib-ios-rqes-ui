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
            .font(EudiRQESUi.getTheme().font.bodyMedium.font)
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
      EudiRQESUi.getTheme().color.onPrimary
    case .secondary:
      EudiRQESUi.getTheme().color.primaryMain
    }
  }
  var backgroundColor: Color {
    switch self {
    case .primary:
      EudiRQESUi.getTheme().color.primaryMain
    case .secondary:
      EudiRQESUi.getTheme().color.onPrimary
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
      EudiRQESUi.getTheme().color.primaryMain
    }
  }
}

