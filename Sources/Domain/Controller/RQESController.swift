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
import RqesKit
import Foundation

protocol RQESController: Sendable {
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
