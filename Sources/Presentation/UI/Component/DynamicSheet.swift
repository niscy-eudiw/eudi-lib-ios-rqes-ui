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
  @ViewBuilder
  func dynamicBottomSheet<Content: View>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View {
    modifier(BottomSheetModifier(isPresented: isPresented, content: content))
  }
}

struct BottomSheetModifier<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  var content: () -> T

  func body(content: Content) -> some View {
    content.sheet(isPresented: $isPresented, content: {
      self.content()
        .sheetSize()
        .sheetConfig()
    })
  }
}

struct SheetSize: Equatable, PreferenceKey {
  static let defaultValue: PresentationDetent = .large
  static func reduce(value _: inout PresentationDetent, nextValue _: () -> PresentationDetent) {}
}

private struct SheetConfig: ViewModifier {
  @State private var sheetDetent: PresentationDetent = .large
  public func body(content: Content) -> some View {
    content
      .onPreferenceChange(SheetSize.self) {
        sheetDetent = $0
      }
      .presentationDragIndicator(.visible)
      .presentationDetents([
        sheetDetent,
      ])
  }
}

struct SheetSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(
      GeometryReader { geometry in
        Color.clear
          .preference(
            key: SheetSize.self,
            value: PresentationDetent.height(geometry.size.height + 1)
          )
      }
    )
  }
}

extension View {
  func sheetSize() -> some View {
    modifier(SheetSizeModifier())
  }

  func sheetConfig() -> some View {
    modifier(SheetConfig())
  }
}
