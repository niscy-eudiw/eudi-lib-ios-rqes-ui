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
import SwiftUI
import Cuckoo
@testable import EudiRQESUi

final class TestLocalizationController: XCTestCase {

  var config: MockEudiRQESUiConfig!
  var controller: LocalizationController!

  override func setUp() {
    self.config = MockEudiRQESUiConfig()
    self.controller = LocalizationControllerImpl(
      config: config,
      locale: .init(identifier: "en_US")
    )
  }

  override func tearDown() {
    self.config = nil
    self.controller = nil
  }
  
  func testGet_WhenTranslationIsAvailableWithoutArgs_ThenReturnsStringTranslation() {
    // Given
    let customGenericErrorTranslation = "CustomGenericError"
    stub(config) { mock in
      when(mock.translations.get).thenReturn(
        ["en_US": [.genericErrorMessage: customGenericErrorTranslation]]
      )
    }
    
    let result = self.controller.get(with: .genericErrorMessage)
    
    XCTAssertEqual(result, customGenericErrorTranslation)
  }
  
  func testGet_WhenTranslationIsAvailableWithoutArgs_ThenReturnsLocalizedStringKeyTranslation() {
    // Given
    let customGenericErrorTranslation = "CustomGenericError"
    stub(config) { mock in
      when(mock.translations.get).thenReturn(
        ["en_US": [.genericErrorMessage: customGenericErrorTranslation]]
      )
    }
    
    let result: LocalizedStringKey = self.controller.get(with: .genericErrorMessage, args: [])
    
    XCTAssertEqual(result, customGenericErrorTranslation.toLocalizedStringKey)
  }
  
  func testGet_WhenTranslationIsNotAvailableWithoutArgs_ThenReturnsDefaultStringTranslation() {
    // Given
    stub(config) { mock in
      when(mock.translations.get).thenReturn([:])
    }
    
    let result = self.controller.get(with: .genericErrorMessage)
    
    XCTAssertEqual(result, LocalizableKey.genericErrorMessage.defaultTranslation(args: []))
  }
  
  func testGet_WhenTranslationIsNotAvailableWithArgs_ThenReturnsDefaultStringTranslation() {
    // Given
    stub(config) { mock in
      when(mock.translations.get).thenReturn([:])
    }

    let result: String = self.controller.get(with: .signedBy, args: ["NISCY"])

    XCTAssertEqual(result, LocalizableKey.signedBy.defaultTranslation(args: ["NISCY"]))
  }

  @MainActor
  func testEnvironmentValuesLocalizationController_Setter_StoresValue() {
    // Given
    var env = EnvironmentValues()
    let preview = PreviewLocalizationController()

    // When
    env.localizationController = preview

    // Then
    XCTAssertTrue(env.localizationController is PreviewLocalizationController)
  }

  @MainActor
  func testEnvironmentValuesLocalizationController_DefaultValue_ResolvesFromDIGraph() async {
    // Given - initialize the SDK so DIGraph is loaded and _config is set
    let bootConfig = MockEudiRQESUiConfig()
    stub(bootConfig) { mock in
      when(mock.theme.get).thenReturn(AppTheme())
    }
    _ = EudiRQESUi(config: bootConfig)

    // When
    let resolved = EnvironmentValues().localizationController

    // Then
    XCTAssertTrue(resolved is LocalizationControllerImpl)
  }

  @MainActor
  func testEnvironmentValuesLocalizationController_DefaultValue_WhenPreviewEnvSet_ReturnsPreview() throws {
    // Given
    setenv("XCODE_RUNNING_FOR_PREVIEWS", "1", 1)
    defer { unsetenv("XCODE_RUNNING_FOR_PREVIEWS") }

    try XCTSkipUnless(
      ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1",
      "ProcessInfo.environment does not reflect runtime env changes on this platform"
    )

    // When
    let resolved = EnvironmentValues().localizationController

    // Then
    XCTAssertTrue(resolved is PreviewLocalizationController)
  }

  func testPreviewLocalizationController_GetWithKey_ReturnsDefaultString() {
    let preview = PreviewLocalizationController()
    let result = preview.get(with: .signDocument)
    XCTAssertEqual(result, LocalizableKey.signDocument.defaultTranslation(args: []))
  }

  func testPreviewLocalizationController_GetWithKeyAndArgs_ReturnsFormattedDefaultString() {
    let preview = PreviewLocalizationController()
    let result: String = preview.get(with: .signedBy, args: ["NISCY"])
    XCTAssertEqual(result, LocalizableKey.signedBy.defaultTranslation(args: ["NISCY"]))
  }

  func testPreviewLocalizationController_GetWithKeyAndArgs_ReturnsLocalizedStringKeyPlaceholder() {
    let preview = PreviewLocalizationController()
    let result: LocalizedStringKey = preview.get(with: .signDocument, args: [])
    XCTAssertEqual(result, LocalizedStringKey("Mocked Translation"))
  }
}
