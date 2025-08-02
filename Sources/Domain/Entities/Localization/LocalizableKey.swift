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
