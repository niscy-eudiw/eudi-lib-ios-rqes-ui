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
  func getQTSps() async throws -> [QTSPData]?
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error>
  func updateQTSP(_ qtsp: QTSPData) async
  func updateDocument(_ url: URL) async
  func createRQESService(_ qtsp: QTSPData) async throws

  @MainActor func openAuthrorizationURL() async throws -> URL
  @MainActor func openCredentialAuthrorizationURL() async throws -> URL
}

final class RQESInteractorImpl: RQESInteractor {

  func createRQESService(_ qtsp: QTSPData) async throws {
    guard let rQESConfig = EudiRQESUi.getConfig().rQESConfig else {
      fatalError("RQES Config has no configuration")
    }
    try await EudiRQESUi.instance().setRQESService(
      .init(
        clientConfig: .init(
          OAuth2Client: CSCClientConfig.OAuth2Client(
            clientId: rQESConfig.clientId,
            clientSecret: rQESConfig.clientSecret
          ),
          authFlowRedirectionURI: rQESConfig.authFlowRedirectionURI,
          scaBaseURL: qtsp.scaURL
        ),
        defaultHashAlgorithmOID: rQESConfig.hashAlgorithm,
        defaultSigningAlgorithmOID:rQESConfig.signingAlgorithm
      )
    )
  }

  func signDocument() async throws -> Document? {
    let authorizationCode = try? await EudiRQESUi.instance().selection.code
    let rQESServiceAuthorized = try await EudiRQESUi.instance().getRQESServiceAuthorized()
    if let authorizationCode,
       let rQESServiceAuthorized {

      let authorizedCredential = try await rQESServiceAuthorized.authorizeCredential(authorizationCode: authorizationCode)
      let signAlgorithm = SigningAlgorithmOID.RSA
      let signedDocuments = try await authorizedCredential.signDocuments(signAlgorithmOID: signAlgorithm)

      return signedDocuments.first
    } else {
      throw RQESError.unableToSignHashDocument
    }
  }

  func getCurrentSelection() async -> CurrentSelection? {
    try? await EudiRQESUi.instance().selection
  }

  func updateQTSP(_ qtsp: QTSPData) async {
    try? await EudiRQESUi.instance().updateQTSP(with: qtsp)
  }

  func updateDocument(_ url: URL) async {
    let name = try? await EudiRQESUi.instance().selection.document?.documentName
    if let name {
      let document = DocumentData(documentName: name, uri: url)
      try? await EudiRQESUi.instance().updateSelectionDocument(with: document)
    }
  }

  func getQTSps() -> [QTSPData]? {
    EudiRQESUi.getConfig().rssps
  }

  @MainActor
  func openAuthrorizationURL() async throws -> URL {
    guard let rqesService = try await EudiRQESUi.instance().getRQESService() else {
      throw RQESError.noRQESServiceProvided
    }
    let _ = try await rqesService.getRSSPMetadata()
    let authorizationUrl = try await rqesService.getServiceAuthorizationUrl()
    return authorizationUrl
  }

  @MainActor
  func openCredentialAuthrorizationURL() async throws -> URL {
    if let uri = try? await EudiRQESUi.instance().selection.document?.uri,
       let certificate = try? await EudiRQESUi.instance().selection.certificate {
      let unsignedDocuments = [
        Document(
          id: UUID().uuidString,
          fileURL: uri
        )
      ]

      let credentialAuthorizationUrl = try await EudiRQESUi.instance().getRQESServiceAuthorized()?.getCredentialAuthorizationUrl(
        credentialInfo: certificate,
        documents: unsignedDocuments
      )

      if let credentialAuthorizationUrl {
        return credentialAuthorizationUrl
      } else {
        throw RQESError.unableToOpenURL
      }
    } else {
      throw RQESError.noDocumentProvided
    }
  }

  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error> {
    if let rqesService = try await EudiRQESUi.instance().getRQESService(),
       let authorizationCode = try? await EudiRQESUi.instance().selection.code {
      do {
        let rQESServiceAuthorized = try await rqesService.authorizeService(authorizationCode: authorizationCode)
        try await EudiRQESUi.instance().setRQESServiceAuthorized(rQESServiceAuthorized)
        let credentials = try? await EudiRQESUi.instance().getRQESServiceAuthorized()?.getCredentialsList()
        if let credentials {
          return .success(credentials)
        } else {
          return .failure(RQESError.unableToFetchCredentials)
        }
      } catch {
        return .failure(error)
      }
    } else {
      return .failure(RQESError.unableToFetchCredentials)
    }
  }
}
