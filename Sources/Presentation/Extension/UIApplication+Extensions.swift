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
public extension UIApplication {

  func topViewController(
    controller: UIViewController? = UIApplication
      .shared
      .connectedScenes
      .filter({ $0.activationState == .foregroundActive })
      .compactMap({ $0 as? UIWindowScene })
      .first?.windows
      .filter({ $0.isKeyWindow })
      .first?
      .rootViewController
  ) -> UIViewController? {

    if let navigationController = controller as? UINavigationController {
      return topViewController(
        controller: navigationController.visibleViewController
      )

    } else if let tabController = controller as? UITabBarController {
      if let selected = tabController.selectedViewController {
        return topViewController(
          controller: selected
        )
      }
    } else if let presented = controller?.presentedViewController {
      return topViewController(
        controller: presented
      )
    }

    return controller
  }
}

extension UIApplication {
  func openURLIfPossible(_ url: URL, onFailure: (() -> Void)? = nil) async {
    guard canOpenURL(url) else {
      onFailure?()
      return
    }
    await open(url)
  }
}
