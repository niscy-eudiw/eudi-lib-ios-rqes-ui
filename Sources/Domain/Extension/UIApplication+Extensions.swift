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
public extension UIApplication {
  // Helper method to get the top-most view controller
  func topViewController(controller: UIViewController? = UIApplication.shared.connectedScenes
    .filter({ $0.activationState == .foregroundActive })
    .compactMap({ $0 as? UIWindowScene })
    .first?.windows
    .filter({ $0.isKeyWindow }).first?.rootViewController) -> UIViewController? {
      
      if let navigationController = controller as? UINavigationController {
        return topViewController(controller: navigationController.visibleViewController)
      }
      if let tabController = controller as? UITabBarController {
        if let selected = tabController.selectedViewController {
          return topViewController(controller: selected)
        }
      }
      if let presented = controller?.presentedViewController {
        return topViewController(controller: presented)
      }
      return controller
    }
}
