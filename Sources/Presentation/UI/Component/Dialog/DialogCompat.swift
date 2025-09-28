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

public extension View {

  @ViewBuilder
  func dialogCompat<A: View, M: View>(
    _ title: String,
    isPresented: Binding<Bool>,
    titleVisibility: Visibility = .automatic,
    @ViewBuilder actions: @escaping () -> A,
    @ViewBuilder message: @escaping () -> M
  ) -> some View {
    modifier(
      DialogCompatModifier(
        isPresented: isPresented,
        title: title,
        titleVisibility: titleVisibility,
        actions: actions,
        message: message
      )
    )
  }
}

private struct DialogCompatModifier<A: View, M: View>: ViewModifier {

  @Binding var isPresented: Bool

  let title: String
  let titleVisibility: Visibility
  let actions: () -> A
  let message: () -> M

  func body(content: Content) -> some View {
    if #available(iOS 26, *) {
      content.alert(
        title,
        isPresented: $isPresented,
        actions: actions,
        message: message
      )
    } else {
      content.confirmationDialog(
        title,
        isPresented: $isPresented,
        titleVisibility: titleVisibility,
        actions: actions,
        message: message
      )
    }
  }
}
