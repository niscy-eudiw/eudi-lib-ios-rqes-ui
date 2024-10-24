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

public protocol EudiRQESUiConfig: Sendable, Equatable {
  
  // Remote signing service provider list
  var rssps : [URL] { get }
  
  // OAuth redirect url
  var redirectUrl: URL? { get }
  
  // Transactions per locale
  var translations: [String: [LocalizableKey: String]] { get }
  
  // Logging is enabled
  var printLogs: Bool { get }
}

// MARK: - TODO To be removed once SDK is stable
public struct DefaultUIConfig: EudiRQESUiConfig {
  
  public let rssps: [URL]
  public let redirectUrl: URL?
  public let translations: [String : [LocalizableKey : String]]
  public let printLogs: Bool
  
  private init(
    rssps: [URL],
    redirectUrl: URL?,
    translations: [String: [LocalizableKey: String]]? = nil,
    printLogs: Bool
  ) {
    self.rssps = rssps
    self.redirectUrl = redirectUrl
    self.translations = translations ?? [:]
    self.printLogs = printLogs
  }
  
  public static func createDefault() -> DefaultUIConfig {
    return DefaultUIConfig(
      rssps: [
        URL(string: "https://www.entrust.com")!,
        URL(string: "https://www.docusign.com")!,
        URL(string: "https://www.ascertia.com")!
      ],
      redirectUrl: URL(string: "openid-rqes://code"),
      printLogs: true
    )
  }
  
}
