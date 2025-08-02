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
import Foundation
import RqesKit

public protocol EudiRQESUiConfig: Sendable {

  // Remote signing service provider list
  var rssps : [QTSPData] { get }

  // Transactions per locale
  var translations: [String: [LocalizableKey: String]] { get }

  // Set SDK Theme
  var theme: ThemeProtocol { get }

  // Can print logs
  var printLogs: Bool { get }
}

extension EudiRQESUiConfig {
  
  public var translations: [String: [LocalizableKey: String]] {
    [:]
  }

  public var theme: ThemeProtocol {
    AppTheme()
  }
}
