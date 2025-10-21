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
import SwiftUI

@Copyable
struct DocumentSelectionState: ViewState {
  let isLoading: Bool
  let documentSelection: SelectionItemData?
  let qtspServiceSelection: SelectionItemData?
  let certificateSelection: SelectionItemData?
  let error: ContentErrorView.Config?
}

final class DocumentSelectionViewModel<Router: RouterGraph>: ViewModel<Router, DocumentSelectionState> {
  
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
      leadingIconTint: EudiRQESUi.requireTheme().color.success,
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
        leadingIconTint: EudiRQESUi.requireTheme().color.success,
        enabled: false
      )
    } else {
      SelectionItemData(
        mainText: .selectService,
        subtitle: .selectServiceSubtitle,
        leadingIcon: Image(.stepTwo),
        leadingIconTint: EudiRQESUi.requireTheme().color.onSurface,
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
      leadingIconTint: EudiRQESUi.requireTheme().color.onSurface,
      action: {
        self.selectCertificate()
      }
    )
  }
}
