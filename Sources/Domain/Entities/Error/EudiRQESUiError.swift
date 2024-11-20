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
import Foundation

public enum EudiRQESUiError: LocalizedError {
  
  case notInitialized
  case invalidState(String)
  case unableToFetchCredentials
  case unableToSignHashDocument
  case unableToOpenURL
  case noRQESServiceProvided
  case noDocumentProvided
  
  public var errorDescription: String? {
    return switch self {
    case .notInitialized:
      "You need to initialize the EudiRQESUi SDK first with an EudiRQESUiConfig Impl"
    case .invalidState(let stateName):
      "State is Invalid - \(stateName)"
    case .unableToFetchCredentials:
      "unableToFetchCredentials"
    case .unableToSignHashDocument:
      "unableToSignHashDocument"
    case .unableToOpenURL:
      "unableToOpenURL"
    case .noRQESServiceProvided:
      "noRQESServiceProvided"
    case .noDocumentProvided:
      "noDocumentProvided"
    }
  }
}
