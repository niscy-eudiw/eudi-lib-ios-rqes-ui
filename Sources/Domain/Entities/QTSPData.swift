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

public struct QTSPData: Equatable, Sendable {
  
  public let name: String
  public let uri: URL
  public let scaUrl: String
  public let tsaUrl: String?
  public let clientId: String
  public let clientSecret: String
  public let authFlowRedirectionURI: String
  public let hashAlgorithm: HashAlgorithmOID

  public init(
    name: String,
    uri: URL,
    scaUrl: String,
    tsaUrl: String?,
    clientId: String,
    clientSecret: String,
    authFlowRedirectionURI: String,
    hashAlgorithm: HashAlgorithmOID
  ) {
    self.name = name
    self.uri = uri
    self.scaUrl = scaUrl
    self.tsaUrl = tsaUrl
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.authFlowRedirectionURI = authFlowRedirectionURI
    self.hashAlgorithm = hashAlgorithm
  }
}
