import SwiftUI

struct ContentErrorView: View {
  @Environment(\.localizationController) var localization

  private let config: Config

  init(config: Config) {
    self.config = config
  }

  var body: some View {
    VStack(alignment: .leading, spacing: SPACING_MEDIUM) {
      HStack {
        Text(localization.get(with: config.title))
          .font(Theme.shared.font.headlineSmall.font)
          .foregroundStyle(Theme.shared.color.onSurface)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      HStack {
        Text(localization.get(with: config.description))
          .font(Theme.shared.font.bodyMedium.font)
          .foregroundStyle(Theme.shared.color.onSurface)
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      Spacer()

      if let action = config.action {
        WrapButtonView(
          style: .primary,
          title: localization.get(with: config.button),
          onAction: action()
        )
      }
    }
    .padding([.all], 16)
  }
}

extension ContentErrorView {
  struct Config {

    let title: LocalizableKey
    let description: LocalizableKey
    let button: LocalizableKey
    let cancelAction: () -> Void
    let action: (() -> Void)?

    public init(
      title: LocalizableKey = .genericErrorMessage,
      description: LocalizableKey = .genericErrorDescription,
      button: LocalizableKey = .genericErrorButtonRetry,
      cancelAction: @escaping @autoclosure () -> Void,
      action: (() -> Void)? = nil
    ) {
      self.title = title
      self.description = description
      self.button = button
      self.action = action
      self.cancelAction = cancelAction
    }
  }
}
