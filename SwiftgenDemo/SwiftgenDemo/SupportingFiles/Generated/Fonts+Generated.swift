// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Inter {
    internal static let bold = FontConvertible(name: "Inter-Bold", family: "Inter", path: "Inter-Bold.ttf")
    internal static let regular = FontConvertible(name: "Inter-Regular", family: "Inter", path: "Inter-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "Inter-SemiBold", family: "Inter", path: "Inter-SemiBold.ttf")
    internal static let all: [FontConvertible] = [bold, regular, semiBold]
  }
  internal static let allCustomFonts: [FontConvertible] = [Inter.bold, Inter.regular, Inter.semiBold]
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(name: name, size: size) else {
      fatalError("Unable to initialize font '\(name)'.")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self.name, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self.name, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self.name, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
    // iOS
    guard let url = BundleToken.bundle.url(forResource: path, withExtension: nil) else { return }

    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
