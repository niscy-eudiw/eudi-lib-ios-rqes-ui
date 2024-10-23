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
  
  public var rssps: [URL] {
    [
      URL(string: "https://www.entrust.com")!,
      URL(string: "https://www.docusign.com")!,
      URL(string: "https://www.ascertia.com")!
    ]
  }
  
  public var redirectUrl: URL? {
    .init(string: "https://www.example.com")
  }
  
  public var translations: [String : [LocalizableKey : String]] {
    [
      "en_US" : [
        .mock : "mock",
        .mockWithValues: "mock %@, %@"
      ]
    ]
  }
  
  public var printLogs: Bool { true }
  
  public init() {
    
  }
}
