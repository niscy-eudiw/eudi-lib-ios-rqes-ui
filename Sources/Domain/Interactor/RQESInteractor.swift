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
import RqesKit

protocol RQESInteractor: Sendable {
  func signDocument() async throws -> Document?
  func getCurrentSelection() async -> CurrentSelection?
  func getQTSps() async -> [QTSPData]
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error>
  func updateQTSP(_ qtsp: QTSPData) async
  func updateDocument(_ url: URL) async
  func createRQESService(_ qtsp: QTSPData) async throws
  func saveCertificate(_ certificate: CredentialInfo) async
  func openAuthrorizationURL() async throws -> URL
  func openCredentialAuthrorizationURL() async throws -> URL
}

final class RQESInteractorImpl: RQESInteractor {
  
  private let rqesUi: EudiRQESUi
  
  init(rqesUi: EudiRQESUi) {
    self.rqesUi = rqesUi
  }
  
  func createRQESService(_ qtsp: QTSPData) async throws {
    let rQESConfig = await rqesUi.getRQESConfig()
    await self.rqesUi.setRQESService(
      .init(
        clientConfig: .init(
          OAuth2Client: CSCClientConfig.OAuth2Client(
            clientId: rQESConfig.clientId,
            clientSecret: rQESConfig.clientSecret
          ),
          authFlowRedirectionURI: rQESConfig.authFlowRedirectionURI,
          scaBaseURL: qtsp.scaURL
        ),
        defaultHashAlgorithmOID: rQESConfig.hashAlgorithm
      )
    )
  }
  
  func signDocument() async throws -> Document? {
    let authorizationCode = await self.rqesUi.selection.code
    let rQESServiceAuthorized = await self.rqesUi.getRQESServiceAuthorized()
    if let authorizationCode,
       let rQESServiceAuthorized {
      
      let authorizedCredential = try await rQESServiceAuthorized.authorizeCredential(authorizationCode: authorizationCode)
      let signedDocuments = try await authorizedCredential.signDocuments()
      
      return signedDocuments.first
    } else {
      throw EudiRQESUiError.unableToSignHashDocument
    }
  }
  
  func getCurrentSelection() async -> CurrentSelection? {
    await self.rqesUi.selection
  }
  
  func updateQTSP(_ qtsp: QTSPData) async {
    await self.rqesUi.updateQTSP(with: qtsp)
  }
  
  func updateDocument(_ url: URL) async {
    let name = await self.rqesUi.selection.document?.documentName
    if let name {
      let document = DocumentData(documentName: name, uri: url)
      await self.rqesUi.updateSelectionDocument(with: document)
    }
  }
  
  func getQTSps() async -> [QTSPData] {
    await rqesUi.getRssps()
  }
  
  func openAuthrorizationURL() async throws -> URL {
    guard let rqesService = await self.rqesUi.getRQESService() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    let _ = try await rqesService.getRSSPMetadata()
    let authorizationUrl = try await rqesService.getServiceAuthorizationUrl()
    return authorizationUrl
  }
  
  func openCredentialAuthrorizationURL() async throws -> URL {
    if let uri = await self.rqesUi.selection.document?.uri,
       let certificate = await self.rqesUi.selection.certificate {
      let unsignedDocuments = [
        Document(
          id: UUID().uuidString,
          fileURL: uri
        )
      ]
      
      let credentialAuthorizationUrl = try await self.rqesUi.getRQESServiceAuthorized()?.getCredentialAuthorizationUrl(
        credentialInfo: certificate,
        documents: unsignedDocuments
      )
      
      if let credentialAuthorizationUrl {
        return credentialAuthorizationUrl
      } else {
        throw EudiRQESUiError.unableToOpenURL
      }
    } else {
      throw EudiRQESUiError.noDocumentProvided
    }
  }
  
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error> {
    if let rqesService = await self.rqesUi.getRQESService(),
       let authorizationCode = await self.rqesUi.selection.code {
      do {
        let rQESServiceAuthorized = try await rqesService.authorizeService(authorizationCode: authorizationCode)
        await self.rqesUi.setRQESServiceAuthorized(rQESServiceAuthorized)
        let credentials = try? await self.rqesUi.getRQESServiceAuthorized()?.getCredentialsList()
        if let credentials {
          return .success(credentials)
        } else {
          return .failure(EudiRQESUiError.unableToFetchCredentials)
        }
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
