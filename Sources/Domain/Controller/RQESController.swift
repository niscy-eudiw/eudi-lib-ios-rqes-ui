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
import RqesKit
import Foundation

protocol RQESController: Sendable {
  func getRSSPMetadata() async throws -> RSSPMetadata
  func getServiceAuthorizationUrl() async throws -> URL
  func authorizeService(_ authorizationCode: String) async throws -> RQESServiceAuthorized
  func authorizeCredential(_ authorizationCode: String) async throws -> RQESServiceCredentialAuthorized
  func signDocuments(_ authorizationCode: String) async throws -> [Document]
  func getCredentialsList() async throws -> [CredentialInfo]
  func getCredentialAuthorizationUrl(credentialInfo: CredentialInfo, documents: [Document]) async throws -> URL
}

final class RQESControllerImpl: RQESController {
  
  private let rqesUi: EudiRQESUi
  
  init(rqesUi: EudiRQESUi) {
    self.rqesUi = rqesUi
  }
  
  func getRSSPMetadata() async throws -> RSSPMetadata {
    guard let rqesService = await self.rqesUi.getRQESService() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    return try await rqesService.getRSSPMetadata()
  }
  
  func getServiceAuthorizationUrl() async throws -> URL {
    guard let rqesService = await self.rqesUi.getRQESService() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    return try await rqesService.getServiceAuthorizationUrl()
  }
  
  func authorizeService(_ authorizationCode: String) async throws -> RQESServiceAuthorized {
    guard let rqesService = await self.rqesUi.getRQESService() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    return try await rqesService.authorizeService(authorizationCode: authorizationCode)
  }
  
  func authorizeCredential(_ authorizationCode: String) async throws -> RQESServiceCredentialAuthorized {
    guard let rqesService = await self.rqesUi.getRQESServiceAuthorized() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    return try await rqesService.authorizeCredential(authorizationCode: authorizationCode)
  }
  
  func signDocuments(_ authorizationCode: String) async throws -> [Document] {
    let authorized = try await authorizeCredential(authorizationCode)
    return try await authorized.signDocuments()
  }
  
  func getCredentialsList() async throws -> [CredentialInfo] {
    guard let rqesService = await self.rqesUi.getRQESServiceAuthorized() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    return try await rqesService.getCredentialsList()
  }
  
  func getCredentialAuthorizationUrl(credentialInfo: CredentialInfo, documents: [Document]) async throws -> URL {
    guard let rqesService = await self.rqesUi.getRQESServiceAuthorized() else {
      throw EudiRQESUiError.noRQESServiceProvided
    }
    return try await rqesService.getCredentialAuthorizationUrl(credentialInfo: credentialInfo, documents: documents)
  }
}
