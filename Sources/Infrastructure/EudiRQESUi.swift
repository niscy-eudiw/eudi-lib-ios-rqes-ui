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
  
  private nonisolated(unsafe) var cancellables = Set<AnyCancellable>()
  
  private static var _shared: EudiRQESUi?
  private static var _config: (any EudiRQESUiConfig)?
  private static var state: State = .none
  
  private var viewController: UIViewController?
  
  @discardableResult
  public init(config: any EudiRQESUiConfig) {
    Self._config = config
    Self._shared = self
    DIGraph.shared.load()
  }
  
  @MainActor
  public func initiate(
    on container: UIViewController = UIApplication.shared.topViewController()!,
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
    notificationListening()
  }
  
  public func resume(
    on container: UIViewController,
    animated: Bool = true
  ) async {
    viewController = await nextViewController()
    await container.present(viewController!, animated: animated)
  }
  
  public func suspend(animated: Bool = true) async {
    await pause(animated: animated)
  }
  
  @MainActor
  private func nextViewController() -> UIViewController {
    let router = InternalRouter()
    switch Self.state {
    case .none:
      fatalError("EudiRQESUi: SDK has not been initialized properly")
    case .initial(
      let document,
      let config
    ):
      return ContainerViewController(
        rootView: RoutingView(
          router: router
        ) {
          DocumentSelectionView(
            router: router,
            document: document,
            services: config.rssps
          )
        }
      )
    case .rssps(let services):
      return ContainerViewController(
        rootView: RoutingView(
          router: router
        ) {
          ServiceSelectionView(
            router: router,
            services: services
          )
        }
      )
    case .credentials:
      return ContainerViewController(
        rootView: RoutingView(
          router: router
        ) {
          CredentialSelectionView(
            router: router
          )
        }
      )
    case .sign(let name, let contents):
      return ContainerViewController(
        rootView: RoutingView(
          router: router
        ) {
          SignedDocumentView(
            router: router,
            initialState: .init(
              name: name,
              contents: contents
            )
          )
        }
      )
    case .view(let source):
      return ContainerViewController(
        rootView: RoutingView(
          router: router
        ) {
          DocumentViewer(
            router: router,
            source: source
          )
        }
      )
    }
  }
  
  @MainActor
  private func notificationListening() {
    NotificationCenter.default.publisher(for: .didCloseDocumentSelection)
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.handleDocumentSelectionClosed()
      }
      .store(in: &cancellables)
    
    NotificationCenter.default.publisher(for: .stateNotification)
      .compactMap { $0.userInfo?["state"] as? State }
      .sink { [weak self] state in
        guard let self = self else { return }
        self.handleNewState(state)
      }
      .store(in: &cancellables)
  }
  
  @MainActor
  private func handleDocumentSelectionClosed() {
    Task {
      await cancel()
    }
  }
  
  @MainActor
  private func handleNewState(_ state: State) {
    Task {
      await setState(state)
    }
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
