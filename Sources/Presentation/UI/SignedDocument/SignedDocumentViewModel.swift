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
      let selection = try? await interactor.getCurrentSelection()

      // TODO: replace from core
      if let uri = selection?.document?.uri {
        createPDF(sourceURL: uri)
      }

      if let documentName = selection?.document?.documentName,
         let qtspName = selection?.qtsp?.qtspName {
        setState {
          $0
            .copy(
              documentName: documentName,
              qtspName: qtspName
            )
        }
      } else {
        setState {
          $0
            .copy(
              error: ContentErrorView.Config(
                title: .genericErrorMessage,
                description: .genericErrorDocumentNotFound,
                cancelAction: {}(),
                action: initiate
              )
            )
        }
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

  private func createPDF(sourceURL: URL) {
    let inputStream = InputStream(url: sourceURL)
    let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.pdf")

    do {
      try savePDF(from: inputStream!, to: destinationURL)
      print("PDF saved successfully at \(destinationURL)")
      pdfURL = destinationURL // Set the pdfURL to the saved location
    } catch {
      print("Failed to save PDF: \(error)")
    }
  }

  private func savePDF(from inputStream: InputStream, to destinationURL: URL) throws {
    inputStream.open()
    defer { inputStream.close() }

    let bufferSize = 1024
    var buffer = [UInt8](repeating: 0, count: bufferSize)

    // Create output file at the destination URL
    if FileManager.default.fileExists(atPath: destinationURL.path) {
      try FileManager.default.removeItem(at: destinationURL)
    }
    FileManager.default.createFile(atPath: destinationURL.path, contents: nil, attributes: nil)

    guard let fileHandle = try? FileHandle(forWritingTo: destinationURL) else {
      throw NSError(domain: "FileError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to create file handle"])
    }
    defer { fileHandle.closeFile() }

    // Read the input stream in chunks and write to the file
    while inputStream.hasBytesAvailable {
      let read = inputStream.read(&buffer, maxLength: bufferSize)
      if read < 0, let error = inputStream.streamError {
        throw error
      }
      fileHandle.write(Data(buffer.prefix(read)))
    }
  }
}

