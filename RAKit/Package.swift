// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RAKit",
    products: [
        .library(name: "RAKit", targets: ["RAKit"]),
    ],
    targets: [
        .target(name: "RAKit"),
    ]
)
