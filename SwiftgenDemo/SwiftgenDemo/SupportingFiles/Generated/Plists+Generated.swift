// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Plist Files

// swiftlint:disable identifier_name line_length number_separator type_body_length
internal enum PlistFiles {
  internal enum AppConfiguration {
    internal static let apiBaseURL: String = "https://api.example.com"
    internal static let apiVersion: String = "v1"
    internal static let enableLogging: Bool = true
    internal static let featureFlags: [String: Any] = ["EnableAnalytics": false, "EnableDarkMode": true, "EnableNotifications": true]
    internal static let maxRetryAttempts: Int = 3
    internal static let supportedLanguages: [String] = ["en", "es", "fr"]
    internal static let timeoutInterval: Int = 30
  }
  internal enum AppSettings {
    internal static let appName: String = "SwiftGen Demo"
    internal static let buildNumber: Int = 1
    internal static let supportEmail: String = "support@example.com"
    internal static let version: String = "1.0.0"
    internal static let websiteURL: String = "https://www.example.com"
  }
}
// swiftlint:enable identifier_name line_length number_separator type_body_length
