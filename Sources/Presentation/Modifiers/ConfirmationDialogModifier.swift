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

extension View {
  func confirmationDialog(
    title: LocalizableKey,
    message: LocalizableKey,
    destructiveText: LocalizableKey,
    baseText: LocalizableKey,
    isPresented: Binding<Bool>,
    destructiveAction: @escaping () -> Void,
    baseAction: @escaping () -> Void
  ) -> some View {
    self.modifier(
      ConfirmationDialogModifier(
        title: title,
        message: message,
        destructiveText: destructiveText,
        baseText: baseText,
        isPresented: isPresented,
        destructiveAction: destructiveAction,
        baseAction: baseAction
      )
    )
  }
}

struct ConfirmationDialogModifier: ViewModifier {
  
  @Environment(\.localizationController) var localization

  let title: LocalizableKey
  let message: LocalizableKey
  let destructiveText: LocalizableKey
  let baseText: LocalizableKey
  let isPresented: Binding<Bool>
  let destructiveAction: () -> Void
  let baseAction: () -> Void

  func body(content: Content) -> some View {
    content
      .confirmationDialog(
        localization.get(with: title),
        isPresented: isPresented,
        titleVisibility: .visible
      ) {
        Button(localization.get(with: destructiveText), role: .destructive) {
          destructiveAction()
        }
        Button(localization.get(with: baseText), role: .cancel) {
          baseAction()
        }
      } message: {
        Text(localization.get(with: message))
      }
  }
}
