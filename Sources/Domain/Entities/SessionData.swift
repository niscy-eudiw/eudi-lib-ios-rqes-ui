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

@Copyable
struct SessionData {
  let document: DocumentData?
  let qtsp: QTSPData?
  let certificate: CredentialInfo?
  let code: String?
  let credentialCertificate: [CredentialInfo]?

  init(
    document: DocumentData? = nil,
    qtsp: QTSPData? = nil,
    certificate: CredentialInfo? = nil,
    code: String? = nil,
    credentialCertificate: [CredentialInfo]? = nil
  ) {
    self.document = document
    self.qtsp = qtsp
    self.certificate = certificate
    self.code = code
    self.credentialCertificate = credentialCertificate
  }
}
