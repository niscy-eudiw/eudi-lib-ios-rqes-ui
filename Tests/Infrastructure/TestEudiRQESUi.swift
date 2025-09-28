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
import XCTest
import UIKit
import Cuckoo
@testable import EudiRQESUi

final class TestEudiRQESUi: XCTestCase {
  
  var router: MockRouterGraph!
  var config: MockEudiRQESUiConfig!
  var eudiRQESUi: EudiRQESUi!
  
  override func setUp() async throws {
    
    self.router = MockRouterGraph()
    self.config = MockEudiRQESUiConfig()
    
    stub(config) { mock in
      when(mock.theme.get).thenReturn(AppTheme())
    }
    
    self.eudiRQESUi = await .init(
      config: config,
      router: router
    )
  }
  
  override func tearDown() {
    self.router = nil
    self.config = nil
    self.eudiRQESUi = nil
  }
  
  func testInitiate_WhenRouterGraphClearAndNextViewCalled_ThenVerifyStateAndCacheAndRouter() async throws {

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
  
  func testResume_WhenRouterGraphClearAndNextViewCalled_ThenVerifyStateAndCacheAndRouter() async throws {
    
    // Given
    let controller = await UIViewController()
    let expectedAuthCode = "123145"
    let expectedState = EudiRQESUi.State.credentials
    
    self.eudiRQESUi = await .init(
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
