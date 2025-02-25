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
struct DocumentSelectionState: ViewState {
  let isLoading: Bool
  let documentSelection: SelectionItemData?
  let qtspServiceSelection: SelectionItemData?
  let certificateSelection: SelectionItemData?
  let error: ContentErrorView.Config?
}

class DocumentSelectionViewModel<Router: RouterGraph>: ViewModel<Router, DocumentSelectionState> {
  
  private let interactor: RQESInteractor
  
  init(
    router: Router,
    interactor: RQESInteractor
  ) {
    self.interactor = interactor
    super.init(
      router: router,
      initialState: DocumentSelectionState(
        isLoading: true,
        documentSelection: nil,
        qtspServiceSelection: nil,
        certificateSelection: nil,
        error: nil
      )
    )
  }
  
  func initiate() async {
    let documentName = await interactor.getSession()?.document?.documentName
    let qtsp = await interactor.getSession()?.qtsp

    if let documentName {
      setState {
        $0.copy(
          isLoading: false,
          documentSelection: createDocumentSelection(
            documentName: documentName
          ),
          qtspServiceSelection: createQtspServiceSelection(
            qtspName: qtsp?.name
          ),
          certificateSelection: qtsp?.name == nil ? nil : createCertificateSelection()
        )
        .copy(error: nil)
      }
    } else {
      errorState()
    }
  }
  
  func viewDocument() {
    router.navigateTo(.viewDocument(false))
  }
  
  func selectService() {
    router.navigateTo(.serviceSelection)
  }

  func selectCertificate() {
    router.navigateTo(.credentialSelection)
  }

  private func errorState() {
    setState {
      $0.copy(
        isLoading: false,
        error: ContentErrorView.Config(
          title: .genericErrorMessage,
          description: .genericErrorDocumentNotFound,
          cancelAction: onCancel,
          action: { Task { await self.initiate() } }
        )
      )
    }
  }

  private func createDocumentSelection(
    documentName: String
  ) -> SelectionItemData {
    SelectionItemData(
      overlineText: .selectDocument,
      mainText: .custom(documentName),
      subtitle: .selectDocumentFromDevice,
      actionText: .view,
      leadingIcon: Image(.stepOne),
      leadingIconTint: Theme.shared.color.success,
      action: {
        self.viewDocument()
      }
    )
  }

  private func createQtspServiceSelection(
    qtspName: String?
  ) -> SelectionItemData {
    if let qtspName {
      SelectionItemData(
        overlineText: .selectService,
        mainText: .custom(qtspName),
        subtitle: .selectServiceSubtitle,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: Theme.shared.color.success,
        enabled: false
      )
    } else {
      SelectionItemData(
        mainText: .selectService,
        subtitle: .selectServiceSubtitle,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: Theme.shared.color.onSurface,
        enabled: true,
        action: {
          self.selectService()
        }
      )
    }
  }

  private func createCertificateSelection() -> SelectionItemData {
    SelectionItemData(
      mainText: .selectCertificate,
      subtitle: .signingCertificateDescription,
      leadingIcon: Image(.stepThree),
      leadingIconTint: Theme.shared.color.onSurface,
      action: {
        self.selectCertificate()
      }
    )
  }
}
