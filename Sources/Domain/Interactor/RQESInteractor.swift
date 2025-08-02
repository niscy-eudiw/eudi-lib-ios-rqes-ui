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

protocol RQESInteractor: Sendable {
  func signDocument() async throws -> Document?
  func getSession() async -> SessionData?
  func getQTSps() async -> [QTSPData]
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error>
  func updateQTSP(_ qtsp: QTSPData?) async
  func updateDocument(_ url: URL) async
  func createRQESService(_ qtsp: QTSPData) async throws
  func saveCertificate(_ certificate: CredentialInfo) async
  func openAuthrorizationURL() async throws -> URL
  func openCredentialAuthrorizationURL() async throws -> URL
}

final class RQESInteractorImpl: RQESInteractor {
  
  private let rqesUi: EudiRQESUi
  private let rqesController: RQESController
  
  init(rqesUi: EudiRQESUi, rqesController: RQESController) {
    self.rqesUi = rqesUi
    self.rqesController = rqesController
  }
  
  func createRQESService(_ qtsp: QTSPData) async throws {
    guard
      let fileExtension = await getSession()?.document?.uri.pathExtension,
      fileExtension.isEmpty == false
    else {
      throw EudiRQESUiError.noDocumentProvided
    }
    await self.rqesUi.setRQESService(
      .init(
        clientConfig: .init(
          OAuth2Client: CSCClientConfig.OAuth2Client(
            clientId: qtsp.clientId,
            clientSecret: qtsp.clientSecret
          ),
          authFlowRedirectionURI: qtsp.authFlowRedirectionURI,
          rsspId: qtsp.rsspId,
          tsaUrl: qtsp.tsaUrl
        ),
        defaultHashAlgorithmOID: qtsp.hashAlgorithm,
        fileExtension: ".\(fileExtension)"
      )
    )
  }
  
  func signDocument() async throws -> Document? {
    let authorizationCode = await self.getSession()?.code
    if let authorizationCode {
      let signedDocuments = try await rqesController.signDocuments(authorizationCode)
      return signedDocuments.first
    } else {
      throw EudiRQESUiError.unableToSignHashDocument
    }
  }
  
  func getSession() async -> SessionData? {
    await self.rqesUi.getSessionData()
  }
  
  func updateQTSP(_ qtsp: QTSPData?) async {
    await self.rqesUi.updateQTSP(with: qtsp)
  }
  
  func updateDocument(_ url: URL) async {
    let name = await self.getSession()?.document?.documentName
    if let name {
      let document = DocumentData(documentName: name, uri: url)
      await self.rqesUi.updateSelectionDocument(with: document)
    }
  }
  
  func getQTSps() async -> [QTSPData] {
    await rqesUi.getRssps()
  }
  
  func openAuthrorizationURL() async throws -> URL {
    let authorizationUrl = try await rqesController.getServiceAuthorizationUrl()
    return authorizationUrl
  }
  
  func openCredentialAuthrorizationURL() async throws -> URL {
    if let uri = await self.getSession()?.document?.uri,
       let certificate = await self.getSession()?.certificate {
      
      let unsignedDocuments = [
        Document(
          id: UUID().uuidString,
          fileURL: uri
        )
      ]
      
      let credentialAuthorizationUrl = try await rqesController.getCredentialAuthorizationUrl(
        credentialInfo: certificate,
        documents: unsignedDocuments
      )
      return credentialAuthorizationUrl
      
    } else {
      throw EudiRQESUiError.noDocumentProvided
    }
  }
  
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error> {
    
    if let credentials = await self.rqesUi.getCredentialInfo() {
      return .success(credentials)
    }
    
    if let authorizationCode = await self.getSession()?.code {
      do {
        let rQESServiceAuthorized = try await rqesController.authorizeService(authorizationCode)
        await self.rqesUi.setRQESServiceAuthorized(rQESServiceAuthorized)
        let credentials = try await rqesController.getCredentialsList()
        await self.rqesUi.updateCredentialInfo(with: credentials)
        return .success(credentials)
      } catch {
        return .failure(error)
      }
    } else {
      return .failure(EudiRQESUiError.unableToFetchCredentials)
    }
  }
  
  func saveCertificate(_ certificate: CredentialInfo) async {
    await self.rqesUi.updateCertificate(with: certificate)
  }
}
