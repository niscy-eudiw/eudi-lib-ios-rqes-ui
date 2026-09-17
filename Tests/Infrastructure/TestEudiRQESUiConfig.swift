/*
 * Copyright (c) 2026 European Commission
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
import XCTest
import MdocDataModel18013
@testable import EudiRQESUi

final class TestEudiRQESUiConfig: XCTestCase {

  private struct MinimalConfig: EudiRQESUiConfig {
    var rssps: [QTSPData] { [TestConstants.mockQtspData] }
    var printLogs: Bool { false }
  }

  private struct LoggingConfig: EudiRQESUiConfig {
    let logger: MockTransactionLogger
    var rssps: [QTSPData] { [TestConstants.mockQtspData] }
    var printLogs: Bool { false }
    var transactionLogger: (any TransactionLogger)? { logger }
  }

  func testTransactionLogger_WhenNotImplemented_ThenDefaultsToNil() {
    // Given
    let config: any EudiRQESUiConfig = MinimalConfig()

    // Then
    XCTAssertNil(config.transactionLogger)
    XCTAssertTrue(config.translations.isEmpty)
  }

  func testTransactionLogger_WhenImplemented_ThenReturnsProvidedLogger() {
    // Given
    let logger = MockTransactionLogger()
    let config: any EudiRQESUiConfig = LoggingConfig(logger: logger)

    // Then
    XCTAssertTrue(config.transactionLogger === logger)
  }
}
