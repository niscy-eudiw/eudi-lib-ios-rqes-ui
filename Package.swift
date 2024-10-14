// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "EudiRQESUi",
  platforms: [.iOS(.v16)],
  products: [
    .library(
      name: "EudiRQESUi",
      targets: ["EudiRQESUi"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/Swinject/Swinject.git",
      from: "2.9.1"
    ),
    .package(
      url: "https://github.com/Brightify/Cuckoo.git",
      from: "2.0.9"
    )
  ],
  targets: [
    .target(
      name: "EudiRQESUi",
      dependencies: [
        "Swinject",
      ],
      path: "./Sources"
    ),
    .testTarget(
      name: "EudiRQESUiTests",
      dependencies: [
        "EudiRQESUi",
        .product(
          name: "Cuckoo",
          package: "Cuckoo"
        )
      ],
      path: "./Tests"
    ),
  ]
)
