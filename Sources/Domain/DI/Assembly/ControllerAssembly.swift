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
import Swinject

final class ControllerAssembly: Assembly {
  
  init() {}
  
  func assemble(container: Container) {
    
    container.register(LocalizationController.self) { r in
      LocalizationControllerImpl(
        config: EudiRQESUi.forceConfig(),
        locale: Locale.current
      )
    }
    .inObjectScope(ObjectScope.container)
    
    container.register(LogController.self) { r in
      LogControllerImpl(config: EudiRQESUi.forceConfig())
    }
    .inObjectScope(ObjectScope.transient)
    
    container.register(PreferencesController.self) { r in
      PreferencesControllerImpl()
    }
    .inObjectScope(ObjectScope.transient)
    
    container.register(RQESController.self) { r in
      RQESControllerImpl(rqesUi: EudiRQESUi.forceInstance())
    }
    .inObjectScope(ObjectScope.transient)
  }
}
