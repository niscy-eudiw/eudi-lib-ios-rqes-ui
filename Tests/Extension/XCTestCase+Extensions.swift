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
import XCTest

extension XCTestCase {
  @MainActor
  func beginObservation(
    _ observed: @escaping @MainActor @Sendable () -> Void,
    description: String = #function
  ) -> XCTestExpectation {
    let exp = expectation(description: description)
    withObservationTracking({
      observed()
    }, onChange: {
      exp.fulfill()
    })
    return exp
  }

  final class StateCapture<T: Sendable> {
    var captured: [T] = []
    var seen = 0
    var shouldContinue = true
  }

  @MainActor
  func beginObservation<T: Sendable>(
    _ read: @escaping @MainActor @Sendable () -> T,
    targetCount: Int = 1,
    includeInitial: Bool = false,
    description: String = #function
  ) -> (exp: XCTestExpectation, states: @MainActor () -> [T]) {

    let exp = expectation(description: description)
    let stateCapture = StateCapture<T>()

    if includeInitial {
      stateCapture.captured.append(read())
    }

    Task { @MainActor in
      while stateCapture.shouldContinue {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
          withObservationTracking({
            _ = read()
          }, onChange: {
            continuation.resume()
          })
        }

        stateCapture.captured.append(read())
        stateCapture.seen += 1

        if stateCapture.seen >= targetCount {
          stateCapture.shouldContinue = false
          exp.fulfill()
        }
      }
    }

    let states: @MainActor () -> [T] = { stateCapture.captured }
    return (exp, states)
  }
}
