// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public static let highlightedText = ColorAsset(name: "highlightedText")
  public static let mainBackground = ColorAsset(name: "mainBackground")
  public static let rowBackground = ColorAsset(name: "rowBackground")
  public static let tabBarBackground = ColorAsset(name: "tabBarBackground")
  public static let text = ColorAsset(name: "text")
}

// MARK: - Extensions

#if canImport(SwiftUI)
public extension SwiftUI.Color {
    static let highlightedText = ColorAsset(name: "highlightedText").swiftUIColor
    static let mainBackground = ColorAsset(name: "mainBackground").swiftUIColor
    static let rowBackground = ColorAsset(name: "rowBackground").swiftUIColor
    static let tabBarBackground = ColorAsset(name: "tabBarBackground").swiftUIColor
    static let text = ColorAsset(name: "text").swiftUIColor
}
#endif

#if os(iOS) || os(tvOS) || os(watchOS)
public extension UIColor {
    static let highlightedText = ColorAsset(name: "highlightedText").color
    static let mainBackground = ColorAsset(name: "mainBackground").color
    static let rowBackground = ColorAsset(name: "rowBackground").color
    static let tabBarBackground = ColorAsset(name: "tabBarBackground").color
    static let text = ColorAsset(name: "text").color
}
#endif

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = Bundle.module
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif
