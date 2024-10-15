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

public final actor EudiRQESUi {
  
  private static var _shared: EudiRQESUi?
  private static var _config: EudiRQESUiConfig?
  
  private var viewController: UIViewController?
  
  @discardableResult
  public init(config: EudiRQESUiConfig) {
    Self._config = config
    Self._shared = self
    DIGraph.shared.load()
  }
  
  public func show(
    on container: UIViewController,
    with state: State,
    animated: Bool = true
  ) async {
    viewController = await UIViewController()
    await container.present(viewController!, animated: animated)
  }
  
  public func dismiss(animated: Bool = true) async {
    await viewController?.dismiss(animated: animated)
    self.viewController = nil
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
  static func getConfig() -> EudiRQESUiConfig {
    return _config!
  }
}

public extension EudiRQESUi {
  enum State: Equatable, Sendable {
    
    case initial
    
    var id: String {
      return switch self {
      case .initial:
        "initial"
      }
    }
    
    public static func == (lhs: State, rhs: State) -> Bool {
      return lhs.id == rhs.id
    }
  }
}
