// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RADemo",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "SplashFeature", targets: ["SplashFeature"]),
        .library(name: "MainFeature", targets: ["MainFeature"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "SearchFeature", targets: ["SearchFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "SplashFeature",
                "MainFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SplashFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "MainFeature",
            dependencies: [
                "HomeFeature",
                "SearchFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SearchFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
