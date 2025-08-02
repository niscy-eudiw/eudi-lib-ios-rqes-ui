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
@testable import EudiRQESUi
import RQESLib
import RqesKit

struct TestConstants {
  
  static let mockDocumentData = DocumentData(
    documentName: "test.pdf",
    uri: URL(string: "file://internal/test.pdf")!
  )
  
  static let mockQtspData: QTSPData = .init(
    name: "Wallet-Centric",
    rsspId: "https://walletcentric.signer.eudiw.dev/csc/v2",
    tsaUrl: nil,
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
}

private extension TestConstants {
  static let mockcCClientConfig: CSCClientConfig = .init(
    OAuth2Client: .init(
      clientId: "client_id",
      clientSecret: "client_secret"
    ),
    authFlowRedirectionURI: "redirect",
    rsspId: "rsspId"
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
