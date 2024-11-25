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

TBD

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
