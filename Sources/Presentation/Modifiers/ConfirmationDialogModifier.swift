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
