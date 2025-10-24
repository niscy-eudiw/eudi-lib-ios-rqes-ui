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

public struct QTSPData: Equatable, Sendable {
  
  public let name: String
  public let rsspId: String
  public let tsaUrl: String?
  public let clientId: String
  public let clientSecret: String
  public let authFlowRedirectionURI: String
  public let hashAlgorithm: HashAlgorithmOID
  public let includeRevocationInfo: Bool

  public init(
    name: String,
    rsspId: String,
    tsaUrl: String?,
    clientId: String,
    clientSecret: String,
    authFlowRedirectionURI: String,
    hashAlgorithm: HashAlgorithmOID,
    includeRevocationInfo: Bool
  ) {
    self.name = name
    self.rsspId = rsspId
    self.tsaUrl = tsaUrl
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.authFlowRedirectionURI = authFlowRedirectionURI
    self.hashAlgorithm = hashAlgorithm
    self.includeRevocationInfo = includeRevocationInfo
  }
}
