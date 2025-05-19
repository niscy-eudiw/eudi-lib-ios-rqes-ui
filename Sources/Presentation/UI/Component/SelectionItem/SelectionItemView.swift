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

struct SelectionItemView: View {
  
  @Environment(\.localizationController) var localization

  let selectionItemData: SelectionItemData
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let enabled: Bool

  init(
    selectionItemData: SelectionItemData,
    verticalPadding: CGFloat = SPACING_MEDIUM,
    horizontalPadding: CGFloat = SPACING_MEDIUM_SMALL,
    enabled: Bool = true
  ) {
    self.selectionItemData = selectionItemData
    self.verticalPadding = verticalPadding
    self.horizontalPadding = horizontalPadding
    self.enabled = enabled
  }

  var body: some View {
    HStack(alignment: .top, spacing: SPACING_MEDIUM_SMALL) {
      if let leadingIcon = selectionItemData.leadingIcon {
        leadingIcon
          .resizable()
          .foregroundStyle(selectionItemData.leadingIconTint)
          .frame(width: 20, height: 20)
      }

      VStack(alignment: .leading, spacing: SPACING_EXTRA_SMALL) {
        if let overline = selectionItemData.overlineText {
          Text(localization.get(with: overline))
            .font(Theme.shared.font.labelLarge.font)
            .foregroundColor(Theme.shared.color.onSurfaceVariant)
        }

        if let mainText = selectionItemData.mainText {
          Text(localization.get(with: mainText))
            .font(Theme.shared.font.titleMedium.font)
            .foregroundColor(Theme.shared.color.onSurface)
            .fontWeight(.bold)
        }

        if let subtitle = selectionItemData.subtitle {
          Text(localization.get(with: subtitle))
            .font(Theme.shared.font.bodyMedium.font)
            .foregroundColor(Theme.shared.color.onSurface)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      HStack(spacing: SPACING_MEDIUM_SMALL) {
        if let actionText = selectionItemData.actionText {
          Text(localization.get(with: actionText))
            .font(.caption2)
            .foregroundColor(Color.accentColor)
        }

        if let trailingIcon = selectionItemData.trailingIcon {
          trailingIcon
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(selectionItemData.trailingIconTint)
        }
      }
    }
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .contentShape(Rectangle())
    .onTapGesture {
      if selectionItemData.enabled {
        selectionItemData.action?()
      }
    }
  }
}

#Preview {
  VStack {
    SelectionItemView(
      selectionItemData: SelectionItemData(
        overlineText: .selectDocument,
        mainText: .custom("File_to_be_signed.pdf"),
        subtitle: .selectDocumentFromDevice,
        actionText: .view,
        leadingIcon: Image(.stepOne),
        trailingIcon: Image(systemName: "chevron.right"),
        enabled: true
      )
    )

    SelectionItemView(
      selectionItemData: SelectionItemData(
        mainText: .custom("Select signing service"),
        subtitle: .selectServiceSubtitle,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: .green,
        trailingIcon: Image(systemName: "chevron.right"),
        enabled: true
      )
    )
  }
  .padding()
  .environment(\.localizationController, PreviewLocalizationController())
}
