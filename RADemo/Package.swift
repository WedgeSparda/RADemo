// swift-tools-version: 5.9

import PackageDescription

enum Module: String, CaseIterable {
    case achievement = "AchievementFeature"
    case app = "AppFeature"
    case game = "GameFeature"
    case gamesForSystem = "GamesForSystemFeature"
    case home = "HomeFeature"
    case main = "MainFeature"
    case navigation = "Navigation"
    case search = "SearchFeature"
    case shared = "Shared"
    case splash = "SplashFeature"
    case systems = "SystemsFeature"
    case user = "UserFeature"
    case resources = "Resources"
    
    var dependencies: [Module] {
        switch self {
        case .achievement:
            []
        case .app:
            [.splash, .main]
        case .game:
            [.shared]
        case .gamesForSystem:
            [.shared]
        case .home:
            [.resources]
        case .main:
            [.home, .navigation, .search, .systems, .resources]
        case .navigation:
            [.achievement, .game, .gamesForSystem, .user]
        case .search:
            [.shared, .navigation]
        case .shared:
            []
        case .splash:
            [.resources]
        case .systems:
            [.navigation, .shared]
        case .user:
            []
        case .resources:
            []
        }
    }
    
    var asDependency: Target.Dependency {
        .targetItem(name: self.rawValue, condition: nil)
    }
}

extension Product {
    static func defineProduct(_ module: Module) -> Product {
        .library(name: module.rawValue, targets: [module.rawValue])
    }
}

extension Target {
    private static let targetBaseDependencies: [Target.Dependency] = [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    ]
    
    static func defineTarget(_ module: Module) -> Target {
        .target(
            name: module.rawValue,
            dependencies: targetBaseDependencies + (module.dependencies.map(\.asDependency))
        )
    }
}

let dependenciesPackages: [Package.Dependency] = [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.8.0")
]

let package = Package(
    name: "RADemo",
    platforms: [.iOS(.v17)],
    products: Module.allCases.map { .defineProduct($0) },
    dependencies: dependenciesPackages,
    targets: Module.allCases.map { .defineTarget($0) }
)
