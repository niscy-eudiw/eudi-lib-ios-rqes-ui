/*
 * Copyright (c) 2025 European Commission
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import UIKit
import RqesKit

public final actor EudiRQESUi {
  
  private static let _shared: InstanceSnapshot = .init()
  private static let _config: ConfigSnapshot = .init()
  private static let _theme: ThemeSnapshot = .init()
  
  @MainActor private let router: any RouterGraph
  @MainActor private var viewController: UIViewController?
  
  private var state: State = .none
  private var session = SessionData()
  private var rqesService: RQESService?
  private var rqesServiceAuthorized: RQESServiceAuthorized?
  
  @MainActor
  @discardableResult
  public init(config: any EudiRQESUiConfig) {
    DIGraph.shared.load()
    self.router = RouterGraphImpl()
    Self._config.value = config
    Self._theme.value = ThemeManager(theme: config.theme)
    Self._shared.value = self
  }
  
  @MainActor
  init(
    config: any EudiRQESUiConfig,
    router: any RouterGraph,
    state: State = .none,
    session: SessionData = .init(),
    rqesService: RQESService? = nil,
    rqesServiceAuthorized: RQESServiceAuthorized? = nil
  ) {
    self.router = router
    self.session = session
    self.state = state
    self.rqesService = rqesService
    self.rqesServiceAuthorized = rqesServiceAuthorized
    Self._config.value = config
    Self._theme.value = ThemeManager(theme: config.theme)
    Self._shared.value = self
  }
  
  @MainActor
  public func initiate(
    on container: UIViewController,
    fileUrl: URL,
    animated: Bool = true
  ) async throws {
    
    self.router.clear()
    
    await resetCache()
    await updateSelectionDocument(
      with: .init(
        documentName: fileUrl.lastPathComponent,
        uri: fileUrl
      )
    )
    await setState(.initial(try Self.getConfig()))
    
    try await launcSDK(on: container, animated: animated)
  }
  
  @MainActor
  public func resume(
    on container: UIViewController,
    authorizationCode: String,
    animated: Bool = true
  ) async throws {
    
    self.router.clear()
    
    await setState(try calculateNextState())
    await updateAuthorizationCode(with: authorizationCode)
    
    try await launcSDK(on: container, animated: animated)
  }
}

public extension EudiRQESUi {
  
  nonisolated static func instance() throws -> EudiRQESUi {
    guard let instance = Self._shared.value else {
      throw EudiRQESUiError.notInitialized
    }
    return instance
  }
}

extension EudiRQESUi {
  
  nonisolated static func getConfig() throws -> (any EudiRQESUiConfig) {
    guard let config = Self._config.value else {
      throw EudiRQESUiError.notInitialized
    }
    return config
  }
  
  nonisolated static func getTheme() throws -> (any ThemeProtocol) {
    guard let theme = Self._theme.value?.theme else {
      throw EudiRQESUiError.notInitialized
    }
    return theme
  }
  
  @MainActor
  func cancel(animated: Bool = true) async {
    await setState(.none)
    await resetCache()
    await pause(animated: animated)
  }
  
  @MainActor
  func pause(animated: Bool = true) async {
    getViewController()?.dismiss(animated: animated)
  }
  
  func updateSelectionDocument(with document: DocumentData? = nil) async {
    session = session.copy(document: document)
  }
  
  func updateQTSP(with qtsp: QTSPData? = nil) async {
    session = session.copy(qtsp: qtsp)
  }
  
  func updateCertificate(with certificate: CredentialInfo) async {
    session = session.copy(certificate: certificate)
  }
  
  func updateCredentialInfo(with info: [CredentialInfo]) async {
    session = session.copy(credentialCertificate: info)
  }
  
  func getCredentialInfo() -> [CredentialInfo]? {
    return session.credentialCertificate
  }
  
  func getSessionData() -> SessionData {
    return self.session
  }
  
  func getState() -> State {
    return self.state
  }
  
  func getRQESService() -> RQESService? {
    self.rqesService
  }
  
  func setRQESService(_ service: RQESService?) {
    self.rqesService = service
  }
  
  func getRQESServiceAuthorized() -> RQESServiceAuthorized? {
    self.rqesServiceAuthorized
  }
  
  func setRQESServiceAuthorized(_ service: RQESServiceAuthorized?) {
    self.rqesServiceAuthorized = service
  }
  
  func getRssps() throws -> [QTSPData] {
    return try Self.getConfig().rssps
  }
}

private extension EudiRQESUi {
  
  @MainActor
  func getViewController() -> UIViewController? {
    return self.viewController
  }
  
  @MainActor
  func setViewController(_ viewController: UIViewController) {
    self.viewController = viewController
  }
  
  @MainActor
  func launcSDK(
    on container: UIViewController,
    animated: Bool
  ) async throws {
    await setViewController(try self.router.nextView(for: getState()))
    if let viewController = getViewController() {
      container.present(viewController, animated: animated)
    }
  }
  
  func calculateNextState() throws -> State {
    switch getState() {
    case .none:
      return .initial(try Self.getConfig())
    case .initial, .rssps:
      return .credentials
    case .credentials:
      return .sign
    case .sign:
      return .view
    case .view:
      return .view
    }
  }
  
  func setState(_ state: State) {
    self.state = state
  }
  
  func resetCache() async {
    session = SessionData()
    setRQESService(nil)
    setRQESServiceAuthorized(nil)
  }
  
  func updateAuthorizationCode(with code: String) async {
    session = session.copy(code: code)
  }
}

private extension EudiRQESUi {
  final class ConfigSnapshot: @unchecked Sendable {
    var value: (any EudiRQESUiConfig)? = nil
  }
  final class InstanceSnapshot: @unchecked Sendable {
    var value: EudiRQESUi? = nil
  }
  final class ThemeSnapshot: @unchecked Sendable {
    var value: ThemeManager? = nil
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
