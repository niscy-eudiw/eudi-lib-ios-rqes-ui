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

public enum LocalizableKey: String, Sendable {

  case signDocument
  case selectDocumentTitle
  case selectDocument
  case confirmSelection
  case confirmSelectionTitle
  case selectService
  case selectServiceTitle
  case selectServiceSubtitle
  case selectCertificate
  case selectCertificateTitle
  case certificate
  case selectCertificateSubtitle
  case success
  case successfullySignedDocument
  case signedBy
  case view
  case done
  case documentSigned
  case shared
  case proceed
  case viewDocument

  func defaultTranslation(args: [String]) -> String {
    let value = switch self {
    case .signDocument: "Sign document"
    case .selectDocumentTitle: "Select a document from your device to sign electronically."
    case .selectDocument: "Select document"
    case .confirmSelection: "Confirm selection"
    case .confirmSelectionTitle: "Please confirm signing of the following."
    case .selectService: "Select service"
    case .selectServiceTitle: "Select remote signing service."
    case .selectServiceSubtitle: "Remote signing enables you to digitally sign documents without the need for locally installed digital identities. Cloud-hosted signing service makes remote signing possible."
    case .selectCertificate: "Select certificate"
    case .selectCertificateTitle: "You have chosen to sign the following document:"
    case .certificate: "CERTIFICATE"
    case .selectCertificateSubtitle: "Please confirm signing with one of the following certificates:"
    case .success: "Success!"
    case .successfullySignedDocument: "You successfully signed your document"
    case .signedBy: "Signed by: %@"
    case .view: "View"
    case .done: "Done"
    case .documentSigned: "Document signed"
    case .shared: "Shared"
    case .proceed: "Proceed"
    case .viewDocument: "View document"
    }
    return value.format(arguments: args)
  }
}
