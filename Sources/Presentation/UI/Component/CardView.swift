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
    HStack(alignment: .center, spacing: SPACING_MEDIUM_SMALL) {
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
