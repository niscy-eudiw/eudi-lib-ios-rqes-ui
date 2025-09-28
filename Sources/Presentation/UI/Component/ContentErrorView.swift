import SwiftUI

struct ContentErrorView: View {
  
  @Environment(\.localizationController) var localization

  private let config: Config

  init(config: Config) {
    self.config = config
  }

  var body: some View {
    VStack(alignment: .leading, spacing: SPACING_LARGE_MEDIUM) {
      HStack {
        Button(
          action: {
            config.cancelAction?()
          },
          label: {
            Image(systemName: "xmark")
              .foregroundColor(.accentColor)
          }
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)

      VStack(alignment: .leading, spacing: SPACING_MEDIUM) {
        HStack {
          Text(localization.get(with: config.title))
            .font(try! EudiRQESUi.getTheme().font.headlineSmall.font)
            .foregroundStyle(try! EudiRQESUi.getTheme().color.onSurface)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

        HStack {
          Text(localization.get(with: config.description))
            .font(try! EudiRQESUi.getTheme().font.bodyMedium.font)
            .foregroundStyle(try! EudiRQESUi.getTheme().color.onSurface)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }

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
  struct Config: Equatable {
    
    let title: LocalizableKey
    let description: LocalizableKey
    let button: LocalizableKey
    let cancelAction: (() -> Void)?
    let action: (() -> Void)?

    public init(
      title: LocalizableKey = .genericErrorMessage,
      description: LocalizableKey = .genericErrorDescription,
      button: LocalizableKey = .genericErrorButtonRetry,
      cancelAction: (() -> Void)? = nil,
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

extension ContentErrorView.Config {
  static func == (lhs: ContentErrorView.Config, rhs: ContentErrorView.Config) -> Bool {
    return lhs.title == rhs.title
    && lhs.description == rhs.description
    && lhs.button == rhs.button
  }
}
