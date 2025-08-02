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

private struct LeftImageModifier: ViewModifier {
  private let image: Image
  private let size: CGFloat?
  private let spacing: CGFloat

  init(
    image: Image,
    spacing: CGFloat,
    size: CGFloat? = nil
  ) {
    self.image = image
    self.spacing = spacing
    self.size = size
  }

  func body(content: Content) -> some View {
    HStack(alignment: .center, spacing: spacing) {
      if let size {
        image
          .resizable()
          .frame(width: size, height: size)
      } else {
        image
      }

      content
    }
  }
}

extension View {
  func leftImage(image: Image, spacing: CGFloat = 0, size: CGFloat? = nil) -> some View {
    modifier(LeftImageModifier(image: image, spacing: spacing, size: size))
  }
}

#Preview {
  Text("Title")
    .leftImage(image: Image(systemName: "calendar"))

  Text("Please review carefully before sharing your data.")
    .leftImage(image: Image(systemName: "calendar"))
}
