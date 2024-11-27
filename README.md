# EUDI Remote Qualified Electronic Signature (RQES) UI library for iOS

:heavy_exclamation_mark: **Important!** Before you proceed, please read
the [EUDI Wallet Reference Implementation project description](https://github.com/eu-digital-identity-wallet/.github/blob/main/profile/reference-implementation.md)

----

## Table of contents

* [Overview](#overview)
* [Installation](#installation)
* [How to use](#how-to-use)
* [License](#license)

## Overview

This package provides the core and UI functionality for the EUDI Wallet, focusing on the Remote Qualified Electronic Signature (RQES) service. 
The `EudiRQESUi` actor defines methods for setting up and using the SDK. The SDK offers compile-time configuration capabilities through the `EudiRQESUiConfig` protocol.

## Requirements

- iOS 16 or higher

## Installation

### Swift Package Manager

Open `Xcode`, go to `File -> Swift Packages -> Add Package Dependency`, and enter `https://github.com/niscy-eudiw/eudi-lib-ios-rqes-ui.git`

You can also add `EudiRQESUi` as a dependency to your `Package.swift`:
```swift
dependencies: [
  .package(url: "https://github.com/eu-digital-identity-wallet/eudi-lib-ios-rqes-ui.git", from: "LATEST_RELEASE")
]
```

```swift
 targets: [
    .target(
      dependencies: [
        .product(
          name: "EudiRQESUi",
          package: "eudi-lib-ios-rqes-ui"
        )
      ]
    )
```

## How to use

### Configuration

Implement the `EudiRQESUiConfig` protocol and supply all the necessary options for the SDK.

```swift
final class RQESConfigImpl: EudiRQESUiConfig {

  var rssps: [QTSPData]

  // Optional. Default is false.
  var printLogs: Bool

  var rQESConfig: RqesServiceConfig

  // Optional. Default English translations will be used if not set.
  var translations: [String : [LocalizableKey : String]]

  // Optional. Default theme will be used if not set.
  var theme: ThemeProtocol
}
```

Example:

```swift
final class RQESConfigImpl: EudiRQESUiConfig {

  var rssps: [QTSPData] {
    return .init(
            name: "your_dev_name",
            uri: URL(string: "your_dev_uri")!,
            scaURL: "your_dev_sca"
        )
  }

  var printLogs: Bool {
    true
  }

  var rQESConfig: RqesServiceConfig {
    return .init(
            clientId: "your_dev_clientid",
            clientSecret: "your_dev_secret",
            authFlowRedirectionURI: "your_registered_deeplink",
            hashAlgorithm: .SHA256
        )
    }
}
```

### Setup

Register the `authFlowRedirectionURI` in your application's plist to ensure the RQES Service can trigger your application.
It is the application's responsibility to retrieve the `code` query parameter from the deep link and pass it to the SDK to continue the flow.

```Xml
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>rqes</string>
		</array>
	</dict>
</array>
```

Initialize the SDK in your AppDelegate by providing your configuration.

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {

    // RQES SDK Setup
    EudiRQESUi.init(config: rqes_config)

    return true
  }
```

Alternatively, you can initialize the SDK wherever needed, avoiding initialization in the AppDelegate. 
However, you must first ensure instance availability before performing any actions.

```swift
let eudiRQESUi: EudiRQESUi
do {
  eudiRQESUi = try EudiRQESUi.instance()
} catch {
  eudiRQESUi = EudiRQESUi.init(config: rqes_config)
}
```

### Initialization

Start the signing process by providing your TopViewController and the URL of the selected file.

```swift
try await EudiRQESUi.instance().initiate(
  on: view_controller,
  fileUrl: file_url
)
```

Resume the signing process once the `authFlowRedirectionURI` triggers your application following the PID presentation process. 
Provide your TopViewController and the extracted code from the `authFlowRedirectionURI` deep link.

```swift
try await EudiRQESUi.instance().resume(
  on: view_controller,
  authorizationCode: code
)
```

If you are using SwiftUI, you can retrieve the TopViewController using the bundled SDK's UIApplication extension function.
Please note that if the application is transitioning from the background to the foreground, this function may return nil for the first ~500 milliseconds.

```swift
let controller = await UIApplication.shared.topViewController()
```

## How to contribute

We welcome contributions to this project. To ensure that the process is smooth for everyone
involved, follow the guidelines found in [CONTRIBUTING.md](CONTRIBUTING.md).

## License

Copyright (c) 2024 European Commission

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
