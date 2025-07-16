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

public enum LocalizableKey: Sendable, Equatable, Hashable {

  case custom(String)
  case signDocument
  case selectDocument
  case selectDocumentFromDevice
  case signingCertificateDescription
  case selectService
  case selectServiceSubtitle
  case selectCertificate
  case certificate
  case selectCertificateSubtitle
  case success
  case successfullySignedDocument
  case signedBy
  case view
  case save
  case documentSigned
  case proceed
  case viewDocument
  case cancel
  case state
  case cancelSigning
  case continueSigning
  case cancelSigningProcessTitle
  case cancelSigningProcessSubtitle
  case genericErrorButtonRetry
  case genericErrorMessage
  case genericServiceErrorMessage
  case genericErrorDescription
  case genericErrorDocumentNotFound
  case genericErrorQtspNotFound
  case sharingDocument
  case closeSharingDocument
  case doneButton
  case share
  case unableToOpenBrowser
  case dataShared

  func defaultTranslation(args: [String]) -> String {
    let value = switch self {
    case .custom(let literal): literal
    case .signDocument: "Sign document"
    case .selectDocument: "Select document"
    case .selectDocumentFromDevice: "Choose a document from your device to sign electronically."
    case .signingCertificateDescription: "The signing certificate is used to verify your identity and is linked to your electronic signature."
    case .selectService: "Select signing service"
    case .selectServiceSubtitle: "Remote Signing Service enables secure online document signing."
    case .selectCertificate: "Select signing certificate"
    case .certificate: "CERTIFICATE"
    case .selectCertificateSubtitle: "Please confirm signing with one of the following certificates:"
    case .success: "Success!"
    case .successfullySignedDocument: "You have successfully signed your document."
    case .signedBy: "%@"
    case .view: "View"
    case .save: "Save"
    case .documentSigned: "Document signed"
    case .proceed: "Proceed"
    case .viewDocument: "View document"
    case .cancel: "Cancel"
    case .state: "State"
    case .cancelSigning: "Cancel signing"
    case .continueSigning: "Continue signing"
    case .cancelSigningProcessTitle: "Cancel signing process?"
    case .cancelSigningProcessSubtitle: "Cancel will redirect you back to the document list without signing your document."
    case .genericErrorButtonRetry: "TRY AGAIN"
    case .genericErrorMessage: "Oups! Something went wrong"
    case .genericServiceErrorMessage: "It seems the RQES Signing service is unavailable. Please try again later."
    case .genericErrorDescription: "If the issue persists, please contact customer support"
    case .genericErrorDocumentNotFound: "No Document data found"
    case .genericErrorQtspNotFound: "No selected QTSP found"
    case .sharingDocument: "Sharing document"
    case .closeSharingDocument: "Closing will redirect you back to the dashboard without saving or sharing the document."
    case .doneButton: "Done"
    case .share: "Share"
    case .unableToOpenBrowser: "Unable to open browser"
    case .dataShared: "Data shared"
    }
    return value.format(arguments: args)
  }
}
