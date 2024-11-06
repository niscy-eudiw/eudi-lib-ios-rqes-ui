import SwiftUI

struct BottomSheetAction {
  let title: String
  let color: Color
  let action: () -> Void

  init(title: String,
       color: Color = Theme.shared.color.onPrimary,
       action: @escaping () -> Void) {
    self.title = title
    self.color = color
    self.action = action
  }
}

struct BottomSheetViewWithActions: View {
  private let title: String
  private let subtitle: String

  private let positiveAction: BottomSheetAction?
  private let negativeAction: BottomSheetAction?

  init(title: String,
       subtitle: String,
       negativeAction: BottomSheetAction? = nil,
       positiveAction: BottomSheetAction? = nil) {
    self.title = title
    self.subtitle = subtitle
    self.positiveAction = positiveAction
    self.negativeAction = negativeAction
  }

  var body: some View {
    VStack(alignment: .leading, spacing: SPACING_MEDIUM) {
      Text(title)
        .font(.largeTitle)
        .foregroundStyle(Theme.shared.color.textPrimaryDark)
      
      Text(subtitle)
        .fixedSize(horizontal: false, vertical: true)
        .foregroundStyle(Theme.shared.color.textPrimaryDark)

      HStack {
        if let negativeAction {
          WrapButtonView(
            style: .secondary,
            title: negativeAction.title,
            onAction: negativeAction.action()
          )
        }
        if let positiveAction {
          WrapButtonView(
            style: .primary,
            title: positiveAction.title,
            onAction: positiveAction.action()
          )
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding(SPACING_MEDIUM)
  }
}

#Preview {
  VStack {
    BottomSheetViewWithActions(
      title: "title",
      subtitle: "subtitle",
      negativeAction: BottomSheetAction(title: "Cancel", action: {}),
      positiveAction: BottomSheetAction(title: "Submit", action: {})
    )
  }
}
