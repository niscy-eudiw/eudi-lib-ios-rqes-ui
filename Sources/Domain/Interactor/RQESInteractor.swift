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

extension Document: @unchecked @retroactive Sendable {}

extension CredentialInfo {
  func toUi() -> CredentialDataUIModel {
    CredentialDataUIModel(
      id: credentialID,
      name: description ?? "Credential"
    )
  }
}

protocol RQESInteractor: Sendable {
  var rqesService: RQESService? { get }
  var rQESServiceAuthorized: RQESServiceAuthorized? { get set }

  func signDocument() async throws -> Document?
  func getCurrentSelection() async -> CurrentSelection?
  func getQTSps() async throws -> [QTSPData]?
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error>
  func updateQTSP(_ qtsp: QTSPData?) async
  func updateDocument(_ url: URL) async
  
  @MainActor func openAuthrorizationURL() async throws -> URL
  @MainActor func openCredentialAuthrorizationURL() async throws -> URL
}

final class RQESInteractorImpl: RQESInteractor {

  nonisolated(unsafe) internal static var _rQESServiceAuthorized: RQESServiceAuthorized? = nil
  nonisolated internal var rQESServiceAuthorized: RQESServiceAuthorized?  {
    get { Self._rQESServiceAuthorized }
    set {
      Self._rQESServiceAuthorized = newValue
    }
  }
  internal let rqesService: RQESService?
  
  init() {
    guard let rQESConfig = EudiRQESUi.getConfig().rQESConfig else {
      fatalError("RQESInteractor has no configuration")
    }
    rqesService = .init(
      clientConfig: rQESConfig,
      defaultHashAlgorithmOID: EudiRQESUi.getConfig().defaultHashAlgorithmOID,
      defaultSigningAlgorithmOID: EudiRQESUi.getConfig().defaultSigningAlgorithmOID
    )
  }
  
  func signDocument() async throws -> Document? {
    let authorizationCode = try? await EudiRQESUi.instance().selection.code
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

  func updateQTSP(_ qtsp: QTSPData? = nil) async {
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
    guard let rqesService = rqesService else {
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

      let credentialAuthorizationUrl = try await rQESServiceAuthorized?.getCredentialAuthorizationUrl(
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
    if let rqesService = rqesService,
       let authorizationCode = try? await EudiRQESUi.instance().selection.code {
      rQESServiceAuthorized = try await rqesService.authorizeService(authorizationCode: authorizationCode)
      do {
        let credentials = try await rQESServiceAuthorized!.getCredentialsList()
        return .success(credentials)
      } catch {
        return .failure(error)
      }
    } else {
      return .failure(RQESError.unableToFetchCredentials)
    }
  }
}
