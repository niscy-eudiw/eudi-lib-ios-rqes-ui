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

struct CertificateDataResponseDTO: Decodable, Equatable, Sendable {
  let name: String
  let certificateURI: URL
}

extension CertificateDataResponseDTO {
  func mapToDomain() -> CertificateData {
    CertificateData(
      name: name,
      certificateURI: certificateURI
    )
  }
}

struct CertificateData: Identifiable {
  let id = UUID()
  let name: String
  let certificateURI: URL
}

enum CredentialSelectionPartialState: Sendable {
  case success([CertificateData])
  case failure(Error)
}

protocol RQESInteractor: Sendable {
  func qtspCertificates(qtspCertificateEndpoint: URL) async -> CredentialSelectionPartialState
  func signDocument(documentUri: URL)
  func getCurrentSelection() async -> CurrentSelection?
  func getQTSps() async throws -> [QTSPData]?
}

final class QTSPInteractorImpl: RQESInteractor {
  func qtspCertificates(qtspCertificateEndpoint: URL) async -> CredentialSelectionPartialState {
    do {
      let qtsps = [
        CertificateDataResponseDTO(name: "Certificate 1", certificateURI: URL(string: "uri 1")!),
        CertificateDataResponseDTO(name: "Certificate 2", certificateURI: URL(string: "uri 2")!),
        CertificateDataResponseDTO(name: "Certificate 3", certificateURI: URL(string: "uri 3")!)
      ].map {
        $0.mapToDomain()
      }
      return .success(qtsps)
    } catch {
      return .failure(error)
    }
  }

  func signDocument(documentUri: URL) {
    // TODO
  }

  func getCurrentSelection() async -> CurrentSelection? {
    try? await EudiRQESUi.instance().selection
  }

  func getQTSps() async throws -> [QTSPData]? {
    try? await EudiRQESUi.getConfig().rssps
  }
}

enum QTSPCertificateError: Error {
    case simulatedError
}
