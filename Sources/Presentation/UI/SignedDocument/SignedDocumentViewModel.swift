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
import SwiftUI

@Copyable
struct SignedDocumenState: ViewState {
  let isLoading: Bool
  let document: DocumentData?
  let qtsp: QTSPData?
  let documentName: String
  let qtspName: String
  let error: ContentErrorView.Config?
}

class SignedDocumentViewModel<Router: RouterGraph>: ViewModel<Router, SignedDocumenState> {

  private let interactor: RQESInteractor
  @Published var pdfURL: URL?

  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: SignedDocumenState(
        isLoading: true,
        document: nil,
        qtsp: nil,
        documentName: "",
        qtspName: "",
        error: nil
      )
    )
  }

  func initiate() {
    Task {
      do {
        let signedDocument = try await interactor.signDocument()
        let selection = await interactor.getCurrentSelection()

        pdfURL = signedDocument?.fileURL
        if let fileURL = signedDocument?.fileURL {
          await interactor.updateDocument(fileURL)
        }
//        if let uri = selection?.document?.uri {
//          createPDF(sourceURL: uri)
//        }

        if let documentName = selection?.document?.documentName,
           let qtspName = selection?.qtsp?.qtspName {
          setState {
            $0
              .copy(
                isLoading: false,
                documentName: documentName,
                qtspName: qtspName
              )
          }
        } else {
          setErrorState()
        }
      } catch {
        setErrorState()
      }
    }
  }

  func viewDocument() {
    if let router = router as? RouterGraphImpl {
      router.navigateTo(
        .viewDocument(true)
      )
    }
  }

  private func setErrorState() {
    setState {
      $0
        .copy(
          isLoading: false,
          error: ContentErrorView.Config(
            title: .genericErrorMessage,
            description: .genericErrorDocumentNotFound,
            cancelAction: initiate,
            action: initiate
          )
        )
    }
  }

//  private func createPDF(sourceURL: URL) {
//    let inputStream = InputStream(url: sourceURL)
//    let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.pdf")
//
//    do {
//      try savePDF(from: inputStream!, to: destinationURL)
//      pdfURL = destinationURL
//    } catch {}
//  }
//
//  private func savePDF(from inputStream: InputStream, to destinationURL: URL) throws {
//    inputStream.open()
//    defer { inputStream.close() }
//
//    let bufferSize = 1024
//    var buffer = [UInt8](repeating: 0, count: bufferSize)
//
//    if FileManager.default.fileExists(atPath: destinationURL.path) {
//      try FileManager.default.removeItem(at: destinationURL)
//    }
//    FileManager.default.createFile(atPath: destinationURL.path, contents: nil, attributes: nil)
//
//    guard let fileHandle = try? FileHandle(forWritingTo: destinationURL) else {
//      throw NSError(domain: "FileError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to create file handle"])
//    }
//    defer { fileHandle.closeFile() }
//
//    while inputStream.hasBytesAvailable {
//      let read = inputStream.read(&buffer, maxLength: bufferSize)
//      if read < 0, let error = inputStream.streamError {
//        throw error
//      }
//      fileHandle.write(Data(buffer.prefix(read)))
//    }
//  }
}

