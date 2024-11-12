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

@Copyable
struct CurrentSelection {
  var document: DocumentData?
  var qtsp: QTSPData?
  var certificate: String?

  init(document: DocumentData? = nil, qtsp: QTSPData? = nil, certificate: String? = nil) {
    self.document = document
    self.qtsp = qtsp
    self.certificate = certificate
  }
}

public final actor EudiRQESUi {
  
  private static var _shared: EudiRQESUi?
  private static var _config: (any EudiRQESUiConfig)?
  private static var _state: State = .none
  private static var _viewController: UIViewController?
  
  private let router: any RouterGraph
  var selection = CurrentSelection()

  @discardableResult
  public init(config: any EudiRQESUiConfig) {
    DIGraph.shared.load()
    self.router = RouterGraphImpl()
    Self._config = config
    Self._shared = self
  }
  
  @MainActor
  public func initiate(
    on container: UIViewController,
    fileUrl: URL,
    animated: Bool = true
  ) async throws {
    guard let config = Self._config else {
      fatalError("EudiRQESUi: SDK has not been initialized properly")
    }
    let document = DocumentData(
      documentName: fileUrl.lastPathComponent,
      uri: fileUrl
    )
    await updateSelectionDocument(with: document)
    await setState(
      .initial(
        config
      )
    )
    try await resume(on: container, animated: animated)
  }
  
  @MainActor
  public func resume(
    on container: UIViewController,
    animated: Bool = true
  ) async throws {
    self.router.clear()
    await setViewController(try self.router.nextView(for: await getState()))
    if let viewController = await getViewController() {
      container.present(viewController, animated: animated)
    }
  }

  func updateSelectionDocument(with document: DocumentData? = nil) async {
    selection.document = document
  }

  func updateQTSP(with qtsp: QTSPData? = nil) async {
    selection.qtsp = qtsp
  }

  func updateCertificate(with certificate: String? = nil) async {
    selection.certificate = certificate
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

private extension EudiRQESUi {
  
  func getState() -> State {
    return Self._state
  }
  
  func getViewController() -> UIViewController? {
    return Self._viewController
  }
  
  func setViewController(_ viewController: UIViewController) {
    Self._viewController = viewController
  }
  
}

extension EudiRQESUi {
  
  static func getConfig() -> any EudiRQESUiConfig {
    return Self._config!
  }
  
  func setState(_ state: State) {
    Self._state = state
  }
  
  @MainActor
  func cancel(animated: Bool = true) async {
    await setState(.none)
    await pause(animated: animated)
  }
  
  @MainActor
  func pause(animated: Bool = true) async {
    await getViewController()?.dismiss(animated: animated)
  }
}

extension EudiRQESUi {
  enum State: Equatable, Sendable {
    
    case none
    case initial(any EudiRQESUiConfig)
    case rssps
    case credentials
    case sign
    case view
    
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
