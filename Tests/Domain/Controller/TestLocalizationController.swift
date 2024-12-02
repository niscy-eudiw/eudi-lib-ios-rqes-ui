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
import XCTest
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
  
  func testGet_WhenTranslationIsAvailableWithoutArgs_ReturnsStringTranslation() {
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
  
  func testGet_WhenTranslationIsAvailableWithoutArgs_ReturnsLocalizedStringKeyTranslation() {
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
  
  func testGet_WhenTranslationIsNotAvailableWithoutArgs_ReturnsDefaultStringTranslation() {
    // Given
    stub(config) { mock in
      when(mock.translations.get).thenReturn([:])
    }
    
    let result = self.controller.get(with: .genericErrorMessage)
    
    XCTAssertEqual(result, LocalizableKey.genericErrorMessage.defaultTranslation(args: []))
  }
  
  func testGet_WhenTranslationIsNotAvailableWithArgs_ReturnsDefaultStringTranslation() {
    // Given
    stub(config) { mock in
      when(mock.translations.get).thenReturn([:])
    }
    
    let result: String = self.controller.get(with: .signedBy, args: ["NISCY"])
    
    XCTAssertEqual(result, LocalizableKey.signedBy.defaultTranslation(args: ["NISCY"]))
  }
  
}
