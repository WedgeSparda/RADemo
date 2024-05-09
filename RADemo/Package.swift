// swift-tools-version: 5.9

import PackageDescription

enum ExternalDependency: String, CaseIterable {
    case composibleArchitecture = "ComposableArchitecture"
    case swiftGenPlugin = "SwiftGenPlugin"
    
    var packageData: (url: String, packageName: String, version: Version) {
        switch self {
        case .composibleArchitecture:
            ("https://github.com/pointfreeco/swift-composable-architecture", "swift-composable-architecture", "1.10.3")
        case .swiftGenPlugin:
            ("https://github.com/SwiftGen/SwiftGenPlugin", "SwiftGenPlugin", "6.6.0")
        }
    }
   
    var asPackageDependency: Package.Dependency {
        .package(url: packageData.url, from: packageData.version)
    }
    
    var asTargetDependency: Target.Dependency {
        .product(name: rawValue, package: packageData.packageName)
    }
    
    var asPlugin: Target.PluginUsage {
        .plugin(name: rawValue, package: packageData.packageName)
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
    case raClient = "RAClient"
    case search = "SearchFeature"
    case shared = "Shared"
    case splash = "SplashFeature"
    case systems = "SystemsFeature"
    case user = "UserFeature"
    case resources = "Resources"
    
    var moduleDependencies: [Module] {
        switch self {
        case .achievement:
            [.resources]
        case .app:
            [.splash, .main]
        case .game:
            [.shared, .resources]
        case .gamesForSystem:
            [.shared, .resources, .raClient]
        case .home:
            [.resources]
        case .main:
            [.home, .navigation, .search, .systems, .resources]
        case .navigation:
            [.achievement, .game, .gamesForSystem, .user]
        case .raClient:
            [.shared]
        case .search:
            [.shared, .navigation]
        case .shared:
            [.resources]
        case .splash:
            [.resources, .raClient]
        case .systems:
            [.navigation, .shared, .resources]
        case .user:
            []
        case .resources:
            []
        }
    }
    
    var pluginDependencies: [Target.PluginUsage] {
        switch self {
        case  .resources:
            [
                ExternalDependency.swiftGenPlugin.asPlugin
            ]
        default:
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
            ] + (moduleDependencies.map(\.asDependency)),
            plugins: pluginDependencies
        )
    }
}

let package = Package(
    name: "RADemo",
    platforms: [.iOS(.v17)],
    products: Module.allCases.map(\.asProduct),
    dependencies: ExternalDependency.allCases.map(\.asPackageDependency),
    targets: Module.allCases.map(\.asTarget)
)
