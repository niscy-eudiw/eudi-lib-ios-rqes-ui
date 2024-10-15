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
import Swinject

final class ControllerAssembly: Assembly {
  
  init() {}
  
  func assemble(container: Container) {
    
    container.register(LocalizationController.self) { r in
      LocalizationControllerImpl(config: EudiRQESUi.getConfig())
    }
    .inObjectScope(ObjectScope.container)
    
    container.register(LogController.self) { r in
      LogControllerImpl(config: EudiRQESUi.getConfig())
    }
    .inObjectScope(ObjectScope.transient)
    
    container.register(PreferencesController.self) { r in
      PreferencesControllerImpl()
    }
    .inObjectScope(ObjectScope.transient)
  }
}
