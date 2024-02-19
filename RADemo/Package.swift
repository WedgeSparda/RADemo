// swift-tools-version: 5.9

import PackageDescription

enum ExternalDependency: String, CaseIterable {
    case composibleArchitecture = "ComposableArchitecture"
    
    var packageData: (url: String, packageName: String, version: Version) {
        switch self {
        case .composibleArchitecture:
            ("https://github.com/pointfreeco/swift-composable-architecture", "swift-composable-architecture", "1.8.0")
        }
    }
   
    var asPackageDependency: Package.Dependency {
        .package(url: packageData.url, from: packageData.version)
    }
    
    var asTargetDependency: Target.Dependency {
        .product(name: rawValue, package: packageData.packageName)
    }
}

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
            [.resources]
        case .app:
            [.splash, .main]
        case .game:
            [.shared, .resources]
        case .gamesForSystem:
            [.shared, .resources]
        case .home:
            [.resources]
        case .main:
            [.home, .navigation, .search, .systems, .resources]
        case .navigation:
            [.achievement, .game, .gamesForSystem, .user]
        case .search:
            [.shared, .navigation]
        case .shared:
            [.resources]
        case .splash:
            [.resources]
        case .systems:
            [.navigation, .shared, .resources]
        case .user:
            []
        case .resources:
            []
        }
    }
    
    var asDependency: Target.Dependency {
        .targetItem(name: self.rawValue, condition: nil)
    }
    
    var asProduct: Product {
        .library(name: rawValue, targets: [rawValue])
    }
    
    var asTarget: Target {
        .target(
            name: rawValue,
            dependencies: [
                ExternalDependency.composibleArchitecture.asTargetDependency
            ] + (dependencies.map(\.asDependency))
        )
    }
    
    var externalDependencies: [ExternalDependency] {
        switch self {
        default:
            []
        }
    }
}

let package = Package(
    name: "RADemo",
    platforms: [.iOS(.v17)],
    products: Module.allCases.map(\.asProduct),
    dependencies: ExternalDependency.allCases.map(\.asPackageDependency),
    targets: Module.allCases.map(\.asTarget)
)
