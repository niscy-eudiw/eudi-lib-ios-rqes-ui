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
  func toDomain() -> CertificateData {
    CertificateData(
      id: credentialID,
      name: description!,
      certificateURI: URL(string: "https://www.example.com")!
    )
  }
}

struct CertificateData: Identifiable, Equatable {
  let id: String
  let name: String
  let certificateURI: URL
}

protocol RQESInteractor: Sendable {
  var rQESServiceAuthorized: RQESServiceAuthorized? { get set }

  func signDocument() async throws -> Document?
  func getCurrentSelection() async -> CurrentSelection?
  func getQTSps() async throws -> [QTSPData]?
  @MainActor
  func openAuthrorizationURL() async throws
  @MainActor
  func openCredentialAuthrorizationURL() async throws
  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error>
  func updateQTSP(_ qtsp: QTSPData?) async
  func updateDocument(_ url: URL) async
}

final class RQESInteractorImpl: RQESInteractor {

  nonisolated(unsafe) internal var rQESServiceAuthorized: RQESServiceAuthorized? = nil

  func signDocument() async throws -> Document? {
    let authorizationCode = try? await EudiRQESUi.instance().selection.code
    if let authorizationCode,
       let rQESServiceAuthorized {

      let authorizedCredential = try await rQESServiceAuthorized.authorizeCredential(authorizationCode: authorizationCode)
      let signAlgorithm = SigningAlgorithmOID.RSA
      let signedDocuments = try await authorizedCredential.signDocuments(signAlgorithmOID: signAlgorithm)
      
      return signedDocuments.first
    } else {
      throw CustomError.unknownError
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

  func getQTSps() async throws -> [QTSPData]? {
    EudiRQESUi.getConfig().rssps
  }

  @MainActor
  func openAuthrorizationURL() async throws {
    let _ = try await EudiRQESUi.instance().rqesService.getRSSPMetadata()
    let authorizationUrl = try await EudiRQESUi.instance().rqesService.getServiceAuthorizationUrl()

    await UIApplication.shared.open(authorizationUrl)
  }

  @MainActor
  func openCredentialAuthrorizationURL() async throws {
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
        await UIApplication.shared.open(credentialAuthorizationUrl)
      } else {
        throw CustomError.unknownError
      }
    } else {
      throw CustomError.unknownError
    }
  }

  func fetchCredentials() async throws -> Result<[CredentialInfo], any Error> {
    if let authorizationCode = try? await EudiRQESUi.instance().selection.code {
      rQESServiceAuthorized = try await EudiRQESUi.instance().rqesService.authorizeService(authorizationCode: authorizationCode)
      do {
        let credentials = try await rQESServiceAuthorized!.getCredentialsList()
        return .success(credentials)
      } catch {
        return .failure(error)
      }
    } else {
      return .failure(CustomError.unknownError)
    }
  }
}

enum CustomError: Error {
  case unknownError
}
