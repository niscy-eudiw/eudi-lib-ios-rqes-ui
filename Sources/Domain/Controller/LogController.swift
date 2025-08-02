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

protocol LogController: Sendable {
  func log(_ error: Error)
  func log(_ description: String)
}

final class LogControllerImpl: LogController {
  
  private static let tag: String = "EudiRQESUi"
  
  private let config: any EudiRQESUiConfig
  
  init(config: any EudiRQESUiConfig) {
    self.config = config
  }
  
  func log(_ error: Error) {
    if config.printLogs {
      print("\(Self.tag): \(error)")
    }
  }
  
  func log(_ description: String) {
    if config.printLogs {
      print("\(Self.tag): \(description)")
    }
  }
}
