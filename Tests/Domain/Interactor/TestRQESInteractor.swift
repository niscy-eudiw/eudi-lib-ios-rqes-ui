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
import RqesKit
@testable import EudiRQESUi

final class TestRQESInteractor: XCTestCase {
  
  var eudiRQESUi: EudiRQESUi!
  var config: MockEudiRQESUiConfig!
  var rqesController: MockRQESController!
  var interactor: RQESInteractorImpl!
  
  override func setUp() {
    self.config = MockEudiRQESUiConfig()
    self.rqesController = MockRQESController()
    self.eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: TestConstants.mockSession
    )
    self.interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
  }
  
  override func tearDown() {
    self.eudiRQESUi = nil
    self.rqesController = nil
    self.config = nil
    self.interactor = nil
  }
  
  func testCreateRQESService_WhenQtspSelected_ThenCreateAndCacheService() async throws {
    // When
    try await interactor.createRQESService(TestConstants.mockQtspData)
    
    // Then
    let service = await eudiRQESUi.getRQESService()
    XCTAssertNotNil(service)
  }
  
  func testCreateRQESService_WhenQtspSelectedButDocumentDataIsNotCached_ThenThrowError() async throws {
    // Given
    let fileUri = try XCTUnwrap(URL(string: "rqes://no_extension"))
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(document: .init(documentName: "test", uri: fileUri))
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    do {
      try await interactor.createRQESService(TestConstants.mockQtspData)
      XCTFail("Error should be thrown here")
    }
    catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.noDocumentProvided.localizedDescription)
    }
  }
  
  func testGetSession_WhenSessionIsCached_ThenReturnSession() async {
    // When
    let session = await interactor.getSession()
    // Then
    XCTAssertNotNil(session)
  }
  
  func testGetQTSps_WhenConfigHasValues_ThenReturnQtsps() async {
    // Given
    stub(config) { mock in
      when(mock.rssps.get).thenReturn(
        [TestConstants.mockQtspData]
      )
    }
    
    // When
    let qtsps = await interactor.getQTSps()
    // Then
    XCTAssertTrue(!qtsps.isEmpty)
  }
  
  func testFetchCredentials_WhenCodeIsCached_ThenReturnCredentialInfoArray() async throws {
    // Given
    let expectedAuthCode = "12345"
    let mockAuthService = await TestConstants.getMockAuthorizedService()
    let expectedCredentialInfo = try await TestConstants.getCredentialInfo()
    
    stub(rqesController) { mock in
      when(mock.authorizeService(any())).thenReturn(
        mockAuthService
      )
    }
    
    stub(rqesController) { mock in
      when(mock.getCredentialsList()).thenReturn(
        [expectedCredentialInfo]
      )
    }
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(code: expectedAuthCode)
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    let credentials = try await interactor.fetchCredentials().get()
    
    // Then
    XCTAssertFalse(credentials.isEmpty)
    
    let service = await eudiRQESUi.getRQESServiceAuthorized()
    XCTAssertNotNil(service)
  }
  
  func testFetchCredentials_WhenCodeIsCachedButServiceThrowsError_ThenReturnError() async {
    // Given
    let expectedAuthCode = "12345"
    let mockAuthService = await TestConstants.getMockAuthorizedService()
    
    stub(rqesController) { mock in
      when(mock.authorizeService(any())).thenReturn(
        mockAuthService
      )
    }
    
    stub(rqesController) { mock in
      when(mock.getCredentialsList()).thenThrow(EudiRQESUiError.unableToFetchCredentials)
    }
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(code: expectedAuthCode)
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    do {
      let _ = try await interactor.fetchCredentials().get()
      XCTFail("Error should be thrown here")
    }
    catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.unableToFetchCredentials.localizedDescription)
    }
  }
  
  func testFetchCredentials_WhenCodeIsNotCached_ThenReturnError() async {
    // When
    do {
      let _ = try await interactor.fetchCredentials().get()
      XCTFail("Error should be thrown here")
    }
    catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.unableToFetchCredentials.localizedDescription)
    }
  }
  
  func testUpdateQTSP_WhenValuePassed_ThenVerifyCachedSelectedQtsp() async {
    // Given
    let expected = TestConstants.mockQtspData
    
    // When
    await interactor.updateQTSP(expected)
    
    // Then
    let stored = await eudiRQESUi.getSessionData().qtsp
    XCTAssertEqual(expected, stored)
  }
  
  func testUpdateDocument_WhenValuePassed_ThenVerifyCachedDocument() async throws {
    // Given
    let newFileUrl = try XCTUnwrap(URL(string: "file://new_path/test.pdf"))
    let expected = DocumentData(
      documentName: "test.pdf",
      uri: newFileUrl
    )
    
    // When
    await interactor.updateDocument(newFileUrl)
    
    // Then
    let stored = await eudiRQESUi.getSessionData().document
    XCTAssertEqual(expected, stored)
  }
  
  func testSaveCertificate_WhenValuePassed_ThenVerifyCachedCertificate() async throws {
    // Given
    let expected = try await TestConstants.getCredentialInfo()
    
    // When
    await interactor.saveCertificate(expected)
    
    // Then
    let stored = await eudiRQESUi.getSessionData().certificate
    XCTAssertNotNil(stored)
  }
  
  func testOpenAuthrorizationURL_WhenMetaDataAndAuthUrlReturnFromService_ThenVerifyUrl() async throws {
    // Given
    let mockMetadata = try await TestConstants.getMetaData()
    let expectedUrl = try XCTUnwrap(URL(string: "rqes://url"))
    
    stub(rqesController) { mock in
      when(mock.getRSSPMetadata()).thenReturn(
        mockMetadata
      )
    }
    
    stub(rqesController) { mock in
      when(mock.getServiceAuthorizationUrl()).thenReturn(
        expectedUrl
      )
    }
    
    // When
    let result = try await interactor.openAuthrorizationURL()
    
    // Then
    XCTAssertEqual(result, expectedUrl)
  }
  
  func testOpenAuthrorizationURL_WhenMetaDataApiThrowsError_ThenThrowError() async {
    // Given
    stub(rqesController) { mock in
      when(mock.getRSSPMetadata()).thenThrow(EudiRQESUiError.unableToOpenURL)
    }
    
    // When
    do {
      let _ = try await interactor.openAuthrorizationURL()
      XCTFail("Error should be thrown here")
    } catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.unableToOpenURL.localizedDescription)
    }
  }
  
  func testOpenCredentialAuthrorizationURL_WhenSessionIsCachedAndValid_ThenReturnValidUrl() async throws {
    // Given
    let mockCredentialInfo = try await TestConstants.getCredentialInfo()
    let expectedUrl = try XCTUnwrap(URL(string: "rqes://url"))
    
    stub(rqesController) { mock in
      when(mock.getCredentialAuthorizationUrl(credentialInfo: any(), documents: any())).thenReturn(expectedUrl)
    }
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(
        document: TestConstants.mockDocumentData,
        certificate: mockCredentialInfo
      )
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    let result = try await interactor.openCredentialAuthrorizationURL()
    
    // Then
    XCTAssertEqual(result, expectedUrl)
    
  }
  
  func testOpenCredentialAuthrorizationURL_WhenSessionIsCachedButCertificateIsNil_ThenThrowError() async {
    // When
    do {
      let _ = try await interactor.openCredentialAuthrorizationURL()
      XCTFail("Error should be thrown here")
    } catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.noDocumentProvided.localizedDescription)
    }
    
  }
  
  func testOpenCredentialAuthrorizationURL_WhenSessionIsCachedAndValidButServiceReturnsError_ThenThrowError() async throws {
    // Given
    let mockCredentialInfo = try await TestConstants.getCredentialInfo()
    
    stub(rqesController) { mock in
      when(mock.getCredentialAuthorizationUrl(credentialInfo: any(), documents: any())).thenThrow(EudiRQESUiError.unableToFetchCredentials)
    }
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(
        document: TestConstants.mockDocumentData,
        certificate: mockCredentialInfo
      )
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    do {
      let _ = try await interactor.openCredentialAuthrorizationURL()
      XCTFail("Error should be thrown here")
    } catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.unableToFetchCredentials.localizedDescription)
    }
    
  }
  
  func testSignDocument_WhenSessionIsValidAndAuthCodeExists_ThenReturnSignedDocument() async throws {
    // Given
    let expectedAuthCode = "12345"
    let mockAuthService = await TestConstants.getMockAuthorizedService()
    let expectedUrl = try XCTUnwrap(URL(string: "rqes://file_path/file.pdf"))
    let expectedSignedDocument: Document = .init(id: "id", fileURL: expectedUrl)
    
    
    stub(rqesController) { mock in
      when(mock.authorizeService(any())).thenReturn(
        mockAuthService
      )
    }
    
    stub(rqesController) { mock in
      when(mock.signDocuments(any())).thenReturn(
        [
          .init(id: "id", fileURL: expectedUrl),
          .init(id: "id2", fileURL: expectedUrl)
        ]
      )
    }
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(code: expectedAuthCode)
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    let result = try await interactor.signDocument()
    
    // Then
    XCTAssertEqual(result?.id, expectedSignedDocument.id)
  }
  
  func testSignDocument_WhenSessionIsValidButAuthCodeDoesNotExists_ThenThrowError() async {
    // When
    do {
      let _ = try await interactor.signDocument()
      XCTFail("Error should be thrown here")
    } catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.unableToSignHashDocument.localizedDescription)
    }
  }
  
  func testSignDocument_WhenSessionIsValidAndAuthCodeExistsButServiceThrowsError_ThenThrowError() async throws {
    // Given
    let expectedAuthCode = "12345"
    let mockAuthService = await TestConstants.getMockAuthorizedService()
    
    
    stub(rqesController) { mock in
      when(mock.authorizeService(any())).thenReturn(
        mockAuthService
      )
    }
    
    stub(rqesController) { mock in
      when(mock.signDocuments(any())).thenThrow(EudiRQESUiError.unableToSignHashDocument)
    }
    
    eudiRQESUi = .init(
      config: config,
      router: MockRouterGraph(),
      session: .init(code: expectedAuthCode)
    )
    
    interactor = RQESInteractorImpl(
      rqesUi: eudiRQESUi,
      rqesController: rqesController
    )
    
    // When
    do {
      let _ = try await interactor.signDocument()
      XCTFail("Error should be thrown here")
    } catch {
      // Then
      XCTAssertEqual(error.localizedDescription, EudiRQESUiError.unableToSignHashDocument.localizedDescription)
    }
  }
  
}
