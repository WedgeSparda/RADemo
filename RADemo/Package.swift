// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RADemo",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "AchievementFeature", targets: ["AchievementFeature"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "GameFeature", targets: ["GameFeature"]),
        .library(name: "GamesForSystemFeature", targets: ["GamesForSystemFeature"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "MainFeature", targets: ["MainFeature"]),
        .library(name: "Navigation", targets: ["Navigation"]),
        .library(name: "SearchFeature", targets: ["SearchFeature"]),
        .library(name: "Shared", targets: ["Shared"]),
        .library(name: "SplashFeature", targets: ["SplashFeature"]),
        .library(name: "SystemsFeature", targets: ["SystemsFeature"]),
        .library(name: "UserFeature", targets: ["UserFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", branch: "observation-beta")
    ],
    targets: [
        .target(
            name: "AchievementFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "SplashFeature",
                "MainFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "GameFeature",
            dependencies: [
                "Shared",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "GamesForSystemFeature",
            dependencies: [
                "Shared",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "MainFeature",
            dependencies: [
                "HomeFeature",
                "Navigation",
                "SearchFeature",
                "SystemsFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "Navigation",
            dependencies: [
                "AchievementFeature",
                "GameFeature",
                "GamesForSystemFeature",
                "UserFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SearchFeature",
            dependencies: [
                "Shared",
                "Navigation",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "Shared",
            dependencies: [
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
            name: "SystemsFeature",
            dependencies: [
                "Navigation",
                "Shared",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "UserFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
