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

struct CardView<Label: View>: View {
  private let title: String
  private let subtitle: String?
  private let trailingView: () -> Label
  private let type: CardViewType
  private let action: (() -> Void)?
  private let trailingAction: (() -> Void)?

  init(
    type: CardViewType = .info,
    title: String,
    subtitle: String? = nil,
    @ViewBuilder trailingView: @escaping () -> Label,
    action: (() -> Void)? = nil,
    trailingAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.subtitle = subtitle
    self.trailingView = trailingView
    self.type = type
    self.action = action
    self.trailingAction = trailingAction
  }

  var body: some View {
    HStack(alignment: .center, spacing: SPACING_MEDIUM) {
      VStack(alignment: .leading, spacing: SPACING_NONE) {
        Text(title)
          .font(Theme.shared.font.bodyLarge.font)
          .foregroundStyle(Theme.shared.color.onSurface)
          .if(subtitle != nil) {
            $0.fontWeight(.semibold)
          }

        if let subtitle {
          Text(subtitle)
            .font(Theme.shared.font.bodySmall.font)
            .foregroundStyle(Theme.shared.color.onSurfaceVariant)
        }
      }
      Spacer()
      Button {
        trailingAction?()
      } label: {
        trailingView()
      }
    }
    .contentShape(Rectangle())
    .onTapGesture {
      action?()
    }
    .padding(SPACING_MEDIUM)
    .frame(height: 80, alignment: .leading)
    .background(type.backgroundColor())
    .cornerRadius(13)
  }
}

#Preview {
  CardView(
    title: "Select document",
    trailingView: { Image(systemName: "plus") },
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingView: { Image(systemName: "plus") },
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingView: { Text("View") },
    action: {}
  )
  .padding()
}

#Preview("Dark Mode") {
  CardView(
    title: "Select document",
    trailingView: { Image(systemName: "plus") },
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingView: { Image(systemName: "plus") },
    action: {}
  )
  .padding()

  CardView(
    type: .success,
    title: "Select document",
    subtitle: "Signed by: Entrust",
    trailingView: { Text("View") },
    action: {}
  )
  .padding()
}
