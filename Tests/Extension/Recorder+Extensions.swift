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
import CombineExpectations

extension Recorder {
  func fetchStates(expectedCount: Int) -> ArraySlice<Input> {
    return try! self.next(expectedCount + 1).get().dropFirst()
  }
  func fetchState() -> Input {
    return try! self.next(2).get().dropFirst().first!
  }
  func isStateEmpty() -> Bool {
    let state = try? self.next(2).get()
    return state == nil
  }
}
