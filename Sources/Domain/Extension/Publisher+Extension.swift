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
import Combine

private struct UncheckedSendable<T>: @unchecked Sendable {
  let unwrap: T
  init(_ value: T) { unwrap = value}
}

extension Publisher where Output: Sendable {
  
  /// Custom sink that supports async/await
  func sinkAsync(receiveValue: @escaping @Sendable (Output) async -> Void) -> AnyCancellable {
    return sink { completion in
      switch completion {
      case .finished:
        break
      case .failure:
        break
      }
    } receiveValue: { value in
      let v = UncheckedSendable(value)
      Task {
        await receiveValue(value)
      }
    }
  }
}
