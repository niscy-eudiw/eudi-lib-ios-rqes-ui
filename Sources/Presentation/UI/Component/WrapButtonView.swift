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

struct WrapButtonView: View {

  private let title: String
  private let onAction: () -> Void
  private let style: ButtonViewStyle
  private let isEnabled: Bool
  private let isLoading: Bool

  init(
    style: ButtonViewStyle,
    title: String,
    isLoading: Bool = false,
    isEnabled: Bool = true,
    onAction: @autoclosure @escaping () -> Void
  ) {
    self.style = style
    self.title = title
    self.isLoading = isLoading
    self.isEnabled = isEnabled
    self.onAction = onAction
  }

  var body: some View {
    Button(action: { onAction() }) {
      Text(title)
        .font(EudiRQESUi.requireTheme().font.bodyLarge.font)
        .fontWeight(.semibold)
        .foregroundStyle(style.textColor)
        .frame(maxWidth: .infinity)
        .padding(SPACING_SMALL)
    }
    .if(!isEnabled && !isLoading) {
      $0.opacity(0.6)
    }
    .buttonStyle(.borderedProminent)
    .tint(style.backgroundColor)
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
      EudiRQESUi.requireTheme().color.white
    case .secondary:
      EudiRQESUi.requireTheme().color.accent
    }
  }

  var backgroundColor: Color {
    switch self {
    case .primary:
      EudiRQESUi.requireTheme().color.accent
    case .secondary:
      EudiRQESUi.requireTheme().color.groupedBackground
    }
  }

}
