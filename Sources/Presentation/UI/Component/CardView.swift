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

enum CardViewType {
  case success
  case info

  func backgroundColor() -> Color {
    switch self {
    case .info: return Theme.shared.color.surfaceContriner
    case .success: return Theme.shared.color.tertiary
    }
  }
}

struct CardView: View {
  private let title: String
  private let subtitle: String?
  private let leadingIcon: Image?
  private let trailingIcon: Image?
  private let type: CardViewType
  private let mainTextVerticalPadding: CGFloat?
  private let action: (() -> Void)?
  private let trailingAction: (() -> Void)?

  init(
    type: CardViewType = .info,
    mainTextVerticalPadding: CGFloat? = nil,
    title: String,
    subtitle: String? = nil,
    leadingIcon: Image? = nil,
    trailingIcon: Image? = Image(systemName: "chevron.right"),
    action: (() -> Void)? = nil,
    trailingAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
    self.trailingIcon = trailingIcon
    self.type = type
    self.mainTextVerticalPadding = mainTextVerticalPadding
    self.action = action
    self.trailingAction = trailingAction
    self.leadingIcon = leadingIcon
  }

  var body: some View {
    HStack(alignment: .center, spacing: SPACING_SMALL) {
      if let leadingIcon {
        leadingIcon
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
      }

      VStack(alignment: .leading, spacing: SPACING_NONE) {
        
        Text(title)
          .font(Theme.shared.font.bodyLarge.font)
          .foregroundStyle(Theme.shared.color.onSurface)
          .lineLimit(2)
          .truncationMode(.tail)
          .fontWeight(.semibold)

        if let subtitle {
          Text(subtitle)
            .font(Theme.shared.font.bodySmall.font)
            .foregroundStyle(Theme.shared.color.onSurfaceVariant)
            .lineLimit(2)
            .truncationMode(.tail)
        }
      }
      Spacer()
      if let trailingIcon {
        trailingIcon
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .foregroundStyle(Color.accentColor)
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      action?()
    }
    .padding(.all, mainTextVerticalPadding != nil ? mainTextVerticalPadding : SPACING_MEDIUM)
    .background(type.backgroundColor())
    .cornerRadius(13)
  }
}

#Preview {
  CardView(
    title: "Select document",
    leadingIcon: Image(.gpdGood),
    trailingIcon: Image(systemName: "plus"),
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingIcon: Image(systemName: "chevron.right"),
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingIcon: Image(systemName: "plus"),
    action: {}
  )
  .padding()
}

#Preview("Dark Mode") {
  CardView(
    title: "Select document",
    trailingIcon: Image(systemName: "plus"),
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingIcon: Image(systemName: "plus"),
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingIcon: Image(systemName: "plus"),
    action: {}
  )
  .padding()
}
