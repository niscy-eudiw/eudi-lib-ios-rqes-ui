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
import UIKit
import Cuckoo
@testable import EudiRQESUi

final class TestEudiRQESUi: XCTestCase {
  
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  
  override func setUp() {
    self.router = MockRouterGraph()
    self.config = MockEudiRQESUiConfig()
    self.eudiRQESUi = .init(
      config: config,
      router: router
    )
  }
  
  override func tearDown() {
    self.router = nil
    self.config = nil
    self.eudiRQESUi = nil
  }
  
  func testInitiate_WhenMethodIsCalled_ThenVerifyStateAndCacheAndRouter() async throws {
    
    // Given
    let controller = await UIViewController()
    let expectedDocumentData = TestConstants.mockDocumentData
    let expectedState = EudiRQESUi.State.initial(self.config)
    
    stub(router) { mock in
      when(mock.clear()).thenDoNothing()
    }
    stub(router) { mock in
      when(mock.nextView(for: expectedState)).thenReturn(controller)
    }
    
    // When
    try await self.eudiRQESUi.initiate(on: UIViewController(), fileUrl: expectedDocumentData.uri)
    
    // Then
    verify(router).clear()
    verify(router).nextView(for: expectedState)
    
    let authService = await eudiRQESUi.getRQESServiceAuthorized()
    let service = await eudiRQESUi.getRQESService()
    XCTAssertNil(service)
    XCTAssertNil(authService)
    
    let session = await eudiRQESUi.getSessionData()
    XCTAssertEqual(session.document, expectedDocumentData)
    
    let state = await eudiRQESUi.getState()
    XCTAssertEqual(state, expectedState)
    
  }
  
  func testResume_WhenMethodIsCalled_ThenVerifyStateAndCacheAndRouter() async throws {
    
    // Given
    let controller = await UIViewController()
    let expectedAuthCode = "123145"
    let expectedState = EudiRQESUi.State.credentials
    
    self.eudiRQESUi = .init(
      config: self.config,
      router: self.router,
      state: .rssps
    )
    
    stub(router) { mock in
      when(mock.clear()).thenDoNothing()
    }
    stub(router) { mock in
      when(mock.nextView(for: expectedState)).thenReturn(controller)
    }
    
    // When
    try await self.eudiRQESUi.resume(on: UIViewController(), authorizationCode: expectedAuthCode)
    
    // Then
    verify(router).clear()
    verify(router).nextView(for: expectedState)
    
    let session = await eudiRQESUi.getSessionData()
    XCTAssertEqual(session.code, expectedAuthCode)
    
    let state = await eudiRQESUi.getState()
    XCTAssertEqual(state, expectedState)
    
  }
  
}
