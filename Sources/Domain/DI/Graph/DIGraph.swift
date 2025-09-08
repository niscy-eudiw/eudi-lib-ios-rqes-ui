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

protocol DIGraphType: Sendable {
  var resolver: Resolver { get }
  var assembler: Assembler { get }
  func load()
}

final class DIGraph: DIGraphType {
  
  static let shared: DIGraphType = DIGraph()
  
  let assembler: Assembler
  
  var resolver: Resolver {
    assembler.resolver
  }
  
  private init() {
    self.assembler = Assembler()
  }
  
  func load() {
    self.assembler.apply(
      assemblies: [
        ControllerAssembly(),
        InteractorAssembly()
      ]
    )
  }
}
