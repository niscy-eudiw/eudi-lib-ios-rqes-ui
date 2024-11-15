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
import Foundation
import RqesKit

public protocol EudiRQESUiConfig: Sendable {
  
  // Remote signing service provider list
  var rssps : [QTSPData] { get }
  
  // OAuth redirect url
  var redirectUrl: URL? { get }
  
  // Transactions per locale
  var translations: [String: [LocalizableKey: String]] { get }
  
  var theme: ThemeProtocol { get }
  
  // Logging is enabled
  var printLogs: Bool { get }
  
  var rQESConfig: CSCClientConfig? { get }
  
  var defaultHashAlgorithmOID: HashAlgorithmOID { get }
  var defaultSigningAlgorithmOID: SigningAlgorithmOID {get }
}

extension EudiRQESUiConfig {
  public var translations: [String: [LocalizableKey: String]] {
    [:]
  }
  
  public var theme: ThemeProtocol {
    AppTheme()
  }
}

// MARK: - TODO To be removed once SDK is stable
public struct DefaultUIConfig: EudiRQESUiConfig {
  
  public let rssps: [QTSPData]
  public let redirectUrl: URL?
  public let printLogs: Bool
  public var theme: ThemeProtocol
  public var rQESConfig: CSCClientConfig?
  public var defaultHashAlgorithmOID: HashAlgorithmOID
  public var defaultSigningAlgorithmOID: SigningAlgorithmOID
  
  private init(
    rssps: [QTSPData],
    redirectUrl: URL?,
    printLogs: Bool,
    theme: ThemeProtocol,
    rQESConfig: CSCClientConfig,
    defaultHashAlgorithmOID: HashAlgorithmOID,
    defaultSigningAlgorithmOID: SigningAlgorithmOID
  ) {
    self.rssps = rssps
    self.redirectUrl = redirectUrl
    self.printLogs = printLogs
    self.theme = theme
    self.rQESConfig = rQESConfig
    self.defaultHashAlgorithmOID = defaultHashAlgorithmOID
    self.defaultSigningAlgorithmOID = defaultSigningAlgorithmOID
    Theme.config(with: theme)
  }
  
  public static func createDefault() -> DefaultUIConfig {
    return DefaultUIConfig(
      rssps: [
        QTSPData(qtspName: "Wallet Centric", uri: URL(string: "https://walletcentric.signer.eudiw.dev")!)
      ],
      redirectUrl: URL(string: "openid-rqes://code"),
      printLogs: true,
      theme: AppTheme(),
      rQESConfig: .init(
        OAuth2Client: CSCClientConfig.OAuth2Client(
          clientId: "wallet-client-tester",
          clientSecret: "somesecrettester2"
        ),
        authFlowRedirectionURI: "rQES://oauth/callback",
        scaBaseURL: "https://walletcentric.signer.eudiw.dev"
      ),
      defaultHashAlgorithmOID: .SHA256,
      defaultSigningAlgorithmOID: .RSA
    )
  }
}
