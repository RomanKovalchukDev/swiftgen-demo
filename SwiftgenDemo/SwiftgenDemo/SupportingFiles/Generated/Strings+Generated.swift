// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Alert {
    /// This is an alert message
    internal static let message = L10n.tr("Localizable", "alert.message", fallback: "This is an alert message")
    /// Alerts
    internal static let title = L10n.tr("Localizable", "alert.title", fallback: "Attention")
  }
  internal enum App {
    /// App Name
    internal static let name = L10n.tr("Localizable", "app.name", fallback: "SwiftGen Demo")
  }
  internal enum Button {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "button.cancel", fallback: "Cancel")
    /// Buttons
    internal static let ok = L10n.tr("Localizable", "button.ok", fallback: "OK")
    /// Save
    internal static let save = L10n.tr("Localizable", "button.save", fallback: "Save")
  }
  internal enum Demo {
    internal enum Colors {
      /// Type-safe color access with SwiftGen
      internal static let description = L10n.tr("Localizable", "demo.colors.description", fallback: "Type-safe color access with SwiftGen")
      /// Demo Sections
      internal static let title = L10n.tr("Localizable", "demo.colors.title", fallback: "Color Palette")
    }
    internal enum Fonts {
      /// Type-safe font access with SwiftGen
      internal static let description = L10n.tr("Localizable", "demo.fonts.description", fallback: "Type-safe font access with SwiftGen")
      /// Custom Fonts
      internal static let title = L10n.tr("Localizable", "demo.fonts.title", fallback: "Custom Fonts")
    }
  }
  internal enum Error {
    /// Network connection error
    internal static let network = L10n.tr("Localizable", "error.network", fallback: "Network connection error")
    /// An unknown error occurred
    internal static let unknown = L10n.tr("Localizable", "error.unknown", fallback: "An unknown error occurred")
  }
  internal enum Items {
    /// Other
    internal static func count(_ p1: Int) -> String {
      return L10n.tr("Localizable", "items.count", p1, fallback: "You have %d items")
    }
  }
  internal enum Success {
    /// Success/Error Messages
    internal static let saved = L10n.tr("Localizable", "success.saved", fallback: "Successfully saved!")
  }
  internal enum Tab {
    /// Colors
    internal static let colors = L10n.tr("Localizable", "tab.colors", fallback: "Colors")
    /// Config
    internal static let config = L10n.tr("Localizable", "tab.config", fallback: "Config")
    /// Fonts
    internal static let fonts = L10n.tr("Localizable", "tab.fonts", fallback: "Fonts")
    /// Tabs
    internal static let home = L10n.tr("Localizable", "tab.home", fallback: "Home")
    /// Images
    internal static let images = L10n.tr("Localizable", "tab.images", fallback: "Images")
    /// Strings
    internal static let strings = L10n.tr("Localizable", "tab.strings", fallback: "Strings")
  }
  internal enum User {
    /// User Greetings
    internal static func greeting(_ p1: Any) -> String {
      return L10n.tr("Localizable", "user.greeting", String(describing: p1), fallback: "Hello, %@!")
    }
    /// %@ has %d items
    internal static func items(_ p1: Any, _ p2: Int) -> String {
      return L10n.tr("Localizable", "user.items", String(describing: p1), p2, fallback: "%@ has %d items")
    }
  }
  internal enum Welcome {
    /// Type-safe access to your resources
    internal static let message = L10n.tr("Localizable", "welcome.message", fallback: "Type-safe access to your resources")
    /// Welcome Messages
    internal static let title = L10n.tr("Localizable", "welcome.title", fallback: "Welcome to SwiftGen")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
