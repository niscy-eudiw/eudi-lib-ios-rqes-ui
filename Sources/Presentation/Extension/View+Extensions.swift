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
  func eraseToAnyView() -> AnyView {
    return AnyView(self)
  }
}

extension View {
  @ViewBuilder func `if`<Content: View>(
    _ condition: Bool,
    transform: (Self) -> Content
  ) -> some View {
    if condition {
      transform(self)
    } else {
      self
    }
  }

  func gone(if shouldHide: Bool) -> some View {
    shouldHide ? AnyView(EmptyView()) : AnyView(self)
  }
}

extension View {
  func lightModePreview() -> some View {
    return self.background(Color.white)
      .environment(\.colorScheme, .light)
      .previewDisplayName("Light Mode")
  }

  func darkModePreview() -> some View {
    return self.background(Color.black)
      .environment(\.colorScheme, .dark)
      .previewDisplayName("Dark Mode")
  }
}
