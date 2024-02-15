// swift-tools-version: 5.9

import PackageDescription

extension Product {
    static func defineProduct(_ featureName: String) -> Product {
        .library(name: featureName, targets: [featureName])
    }
}

extension Target {
    private static let targetBaseDependencies: [Target.Dependency] = [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    ]
    
    static func defineTarget(_ featureName: String, dependencies: [Target.Dependency] = []) -> Target {
        .target(
            name: featureName,
            dependencies: targetBaseDependencies + dependencies
        )
    }
}

let platforms: [SupportedPlatform] = [.iOS(.v17)]

let products: [Product] = [
    .defineProduct("AchievementFeature"),
    .defineProduct("AppFeature"),
    .defineProduct("GameFeature"),
    .defineProduct("GamesForSystemFeature"),
    .defineProduct("HomeFeature"),
    .defineProduct("MainFeature"),
    .defineProduct("Navigation"),
    .defineProduct("SearchFeature"),
    .defineProduct("Shared"),
    .defineProduct("SplashFeature"),
    .defineProduct("SystemsFeature"),
    .defineProduct("UserFeature")
]

let dependenciesPackages: [Package.Dependency] = [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0")
]

let package = Package(
    name: "RADemo",
    platforms: platforms,
    products: products,
    dependencies: dependenciesPackages,
    targets: [
        .defineTarget("AchievementFeature"),
        .defineTarget(
            "AppFeature",
            dependencies: [
                "SplashFeature",
                "MainFeature"
            ]
        ),
        .defineTarget(
            "GameFeature",
            dependencies: [
                "Shared"
            ]
        ),
        .defineTarget(
            "GamesForSystemFeature",
            dependencies: [
                "Shared"
            ]
        ),
        .defineTarget("HomeFeature"),


        .defineTarget(
            "MainFeature",
            dependencies: [
                "HomeFeature",
                "Navigation",
                "SearchFeature",
                "SystemsFeature"
            ]
        ),
        .defineTarget(
            "Navigation",
            dependencies: [
                "AchievementFeature",
                "GameFeature",
                "GamesForSystemFeature",
                "UserFeature"
            ]
        ),
        .defineTarget(
            "SearchFeature",
            dependencies: [
                "Shared",
                "Navigation"
            ]
        ),
        .defineTarget("Shared"),
        .defineTarget("SplashFeature"),
        .defineTarget(
            "SystemsFeature",
            dependencies: [
                "Navigation",
                "Shared"
            ]
        ),
        .defineTarget("UserFeature")
    ]
)
