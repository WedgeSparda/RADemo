// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RADemo",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "Shared", targets: ["Shared"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "SplashFeature", targets: ["SplashFeature"]),
        .library(name: "MainFeature", targets: ["MainFeature"]),
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "GameFeature", targets: ["GameFeature"]),
        .library(name: "UserFeature", targets: ["UserFeature"]),
        .library(name: "AchievementFeature", targets: ["AchievementFeature"]),
        .library(name: "SearchNavigation", targets: ["SearchNavigation"]),
        .library(name: "SearchFeature", targets: ["SearchFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.4.2"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.1.0")
    ],
    targets: [
        .target(name: "Shared"),
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
                "SearchNavigation",
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
            name: "GameFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "UserFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "AchievementFeature",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SearchNavigation",
            dependencies: [
                "SearchFeature",
                "GameFeature",
                "UserFeature",
                "AchievementFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .target(
            name: "SearchFeature",
            dependencies: [
                "Shared",
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        )
    ]
)
