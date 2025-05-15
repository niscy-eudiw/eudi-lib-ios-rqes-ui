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
@testable import EudiRQESUi
import RQES_LIBRARY
import RqesKit

struct TestConstants {
  
  static let mockDocumentData = DocumentData(
    documentName: "test.pdf",
    uri: URL(string: "file://internal/test.pdf")!
  )
  
  static let mockQtspData: QTSPData = .init(
    name: "Wallet-Centric",
    uri: URL(string: "https://walletcentric.signer.eudiw.dev/csc/v2")!,
    scaURL: "https://walletcentric.signer.eudiw.dev",
    clientId: "wallet-client",
    clientSecret: "somesecret2",
    authFlowRedirectionURI: "rqes://oauth/callback",
    hashAlgorithm: .SHA256
  )
  
  static let mockSession: SessionData = .init(document: TestConstants.mockDocumentData)
  
  static func getMockAuthorizedService() async -> RQESServiceAuthorized {
    let mockRQES: RQES = await .init(
      cscClientConfig: mockcCClientConfig
    )
    return .init(
      mockRQES,
      clientConfig: mockcCClientConfig,
      defaultHashAlgorithmOID: .SHA256,
      defaultSigningAlgorithmOID: .RSA,
      fileExtension: ".pdf",
      state: "state",
      accessToken: "access_token"
    )
  }
  
  static func getCredentialInfo() async throws -> CredentialsListResponse.CredentialInfo {
    return try JSONDecoder().decode(CredentialsListResponse.CredentialInfo.self, from: Data(mockCredentialJson.utf8))
  }
  
  static func getMetaData() async throws -> RSSPMetadata {
    return try JSONDecoder().decode(RSSPMetadata.self, from: Data(mockMetaData.utf8))
  }
}

private extension TestConstants {
  static let mockcCClientConfig: CSCClientConfig = .init(
    OAuth2Client: .init(
      clientId: "client_id",
      clientSecret: "client_secret"
    ),
    authFlowRedirectionURI: "redirect",
    scaBaseURL: "sca"
  )
  
  static let mockCredentialJson =
  """
{
   "credentialID":"id",
   "key":{
      "status":"status",
      "algo":[
         "TEST",
         "TEST",
         "TEST"
      ],
      "len":1
   },
   "cert":{
      "status":"status",
      "issuerDN":"issuerDN",
      "serialNumber":"serialNumber",
      "subjectDN":"subjectDN",
      "validFrom":"validFrom",
      "validTo":"validTo",
      "certificates":[
         "TEST",
         "TEST",
         "TEST"
      ],
      "len":1
   }
}
"""
  
  static let mockMetaData =
  """
{
  "specs": "Specification details",
  "name": "Service Name",
  "logo": "https://example.com/logo.png",
  "region": "Europe",
  "lang": "en",
  "description": "This is a detailed description of the service.",
  "authType": ["OAuth2", "APIKey"],
  "oauth2": "https://example.com/oauth2",
  "methods": ["GET", "POST", "PUT"],
  "validationInfo": true,
  "signAlgorithms": {
    "algos": ["RS256", "ES256"],
    "algoParams": ["param1", "param2"]
  },
  "signature_formats": {
    "formats": ["XML", "JSON"],
    "envelope_properties": [
      ["property1", "property2"],
      ["property3", "property4"]
    ]
  },
  "conformance_levels": ["Basic", "Advanced"]
}

"""
}
