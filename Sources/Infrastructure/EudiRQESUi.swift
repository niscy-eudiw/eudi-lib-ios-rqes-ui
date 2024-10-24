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
import UIKit

extension Notification: @unchecked @retroactive Sendable {}

public final actor EudiRQESUi {
  
  private nonisolated(unsafe) var cancellables = Set<AnyCancellable>()
  private nonisolated(unsafe) var viewController: UIViewController?
  
  private static var _shared: EudiRQESUi?
  private static var _config: (any EudiRQESUiConfig)?
  private static var state: State = .none
  
  @discardableResult
  public init(config: any EudiRQESUiConfig) {
    Self._config = config
    Self._shared = self
    DIGraph.shared.load()
  }
  
  @MainActor
  public func initiate(
    on container: UIViewController = UIApplication.shared.topViewController(),
    fileUrl: URL,
    animated: Bool = true
  ) async {
    guard let config = Self._config else {
      fatalError("EudiRQESUi: SDK has not been initialized properly")
    }
    await setState(
      .initial(
        fileUrl,
        config
      )
    )
    await resume(on: container, animated: animated)
  }
  
  @MainActor
  public func resume(
    on container: UIViewController = UIApplication.shared.topViewController(),
    animated: Bool = true
  ) async {
    viewController = nextViewController()
    if let viewController = viewController {
      container.present(viewController, animated: animated)
    }
  }
  
  @MainActor
  private func nextViewController() -> UIViewController {
    let router = DIGraph.resolver.force(
      (any RouterGraph).self
    )
    return router.nextView(for: Self.state)
  }
}

public extension EudiRQESUi {
  static func instance() throws -> EudiRQESUi {
    guard let _shared else {
      throw EudiRQESUiError.notInitialized
    }
    return _shared
  }
}

extension EudiRQESUi {
  
  static func getConfig() -> any EudiRQESUiConfig {
    return Self._config!
  }
  
  func setState(_ state: State) {
    Self.state = state
  }
  
  func getState() -> State {
    return Self.state
  }
  
  func cancel(animated: Bool = true) async {
    setState(.none)
    await pause(animated: animated)
  }
  
  func pause(animated: Bool = true) async {
    await viewController?.dismiss(animated: animated)
  }
}

extension EudiRQESUi {
  enum State: Equatable, Sendable {
    
    case none
    case initial(URL, any EudiRQESUiConfig)
    case rssps([URL])
    case credentials
    case sign(String, String)
    case view(DocumentSource)
    
    var id: String {
      return switch self {
      case .none:
        "none"
      case .initial:
        "initial"
      case .rssps:
        "rssps"
      case .credentials:
        "credentials"
      case .sign:
        "sign"
      case .view:
        "view"
      }
    }
    
    public static func == (lhs: State, rhs: State) -> Bool {
      return lhs.id == rhs.id
    }
  }
}
