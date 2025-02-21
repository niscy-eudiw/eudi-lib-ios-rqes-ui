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

struct SelectionItem: View {
  let selectionItemData: selectionItemData
  let verticalPadding: CGFloat
  let horizontalPadding: CGFloat
  let enabled: Bool
  let action: (() -> Void)?

  init(
    selectionItemData: selectionItemData,
    verticalPadding: CGFloat = SPACING_MEDIUM,
    horizontalPadding: CGFloat = SPACING_MEDIUM_SMALL,
    enabled: Bool = true,
    action: (() -> Void)?
  ) {
    self.selectionItemData = selectionItemData
    self.verticalPadding = verticalPadding
    self.horizontalPadding = horizontalPadding
    self.enabled = enabled
    self.action = action
  }

  var body: some View {
    HStack(alignment: .top, spacing: SPACING_MEDIUM_SMALL) {
      if let leadingIcon = selectionItemData.leadingIcon {
        Text(leadingIcon.text)
          .font(.headline)
          .foregroundColor(.white)
          .frame(width: 20, height: 20)
          .background(leadingIcon.backgroundColor)
          .cornerRadius(4)
      }

      VStack(alignment: .leading, spacing: SPACING_EXTRA_SMALL) {
        if let overline = selectionItemData.overlineText {
          Text(overline)
            .font(Theme.shared.font.labelLarge.font)
            .foregroundColor(Theme.shared.color.onSurfaceVariant)
        }

        if let mainText = selectionItemData.mainText {
          Text(mainText)
            .font(Theme.shared.font.titleMedium.font)
            .foregroundColor(Theme.shared.color.onSurface)
            .fontWeight(.bold)
        }

        if let subtitle = selectionItemData.subtitle {
          Text(subtitle)
            .font(Theme.shared.font.bodyMedium.font)
            .foregroundColor(Theme.shared.color.onSurface)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      HStack(spacing: SPACING_MEDIUM_SMALL) {
        if let actionText = selectionItemData.actionText {
          Text(actionText)
            .font(.caption2)
            .foregroundColor(.blue)
        }

        if let trailingIcon = selectionItemData.trailingIcon {
          trailingIcon
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(selectionItemData.trailingIconTint ?? .blue)
        }
      }
    }
    .padding(.vertical, verticalPadding)
    .padding(.horizontal, horizontalPadding)
    .disabled(!enabled)
    .contentShape(Rectangle())
    .onTapGesture {
      action?()
    }
  }
}

#Preview {
  VStack {
    SelectionItem(
      selectionItemData: selectionItemData(
        overlineText: "Select document",
        mainText: "File_to_be_signed.pdf",
        subtitle: "Choose a document from your device to sign electronically.",
        actionText: "VIEW",
        leadingIcon: (
          text: "1",
          backgroundColor: .green
        ),
        trailingIcon: Image(systemName: "chevron.right"),
        enabled: true
      ),
      action: {}
    )

    SelectionItem(
      selectionItemData: selectionItemData(
        mainText: "Select signing service",
        subtitle: "Remote Signing Service enables secure online document signing.",
        leadingIcon: (
          text: "2",
          backgroundColor: .black
        ),
        trailingIcon: Image(systemName: "chevron.right"),
        enabled: true
      ),
      action: {}
    )
  }
  .padding()
}
