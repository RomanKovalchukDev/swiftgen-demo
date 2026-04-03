# SwiftGen Usage Examples

Comprehensive examples demonstrating SwiftGen usage patterns across different resource types.

## Table of Contents

- [Asset Catalogs (Colors & Images)](#asset-catalogs)
- [Localized Strings](#localized-strings)
- [Custom Fonts](#custom-fonts)
- [Plist Files](#plist-files)
- [UIKit Examples](#uikit-examples)
- [SwiftUI Examples](#swiftui-examples)
- [Common Patterns](#common-patterns)

---

## Asset Catalogs

### Colors

#### Basic Color Usage (UIKit)

```swift
import UIKit

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Brand colors
        view.backgroundColor = Asset.Colors.backgroundPrimary.color

        let label = UILabel()
        label.textColor = Asset.Colors.textPrimary.color

        // Semantic colors
        let successLabel = UILabel()
        successLabel.textColor = Asset.Colors.successColor.color

        let errorLabel = UILabel()
        errorLabel.textColor = Asset.Colors.errorColor.color
    }
}
```

#### Color Usage (SwiftUI)

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome")
                .foregroundColor(Asset.Colors.textPrimary.swiftUIColor)

            Text("Success Message")
                .foregroundColor(Asset.Colors.successColor.swiftUIColor)

            Text("Error Message")
                .foregroundColor(Asset.Colors.errorColor.swiftUIColor)
        }
        .padding()
        .background(Asset.Colors.backgroundPrimary.swiftUIColor)
    }
}
```

#### Dynamic Color Support

```swift
import UIKit

// Colors automatically adapt to light/dark mode if configured in Assets
let adaptiveColor = Asset.Colors.primaryColor.color

// Force specific trait collection (iOS 13+)
if #available(iOS 13.0, *) {
    let lightMode = UITraitCollection(userInterfaceStyle: .light)
    let darkMode = UITraitCollection(userInterfaceStyle: .dark)

    let lightColor = Asset.Colors.primaryColor.color(compatibleWith: lightMode)
    let darkColor = Asset.Colors.primaryColor.color(compatibleWith: darkMode)
}
```

### Images

#### Image Usage (UIKit)

```swift
import UIKit

class ImageExamplesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Direct image access
        let imageView = UIImageView(image: Asset.Icons.testImage.image)

        // Button with image
        let button = UIButton(type: .system)
        button.setImage(Asset.Icons.testImage.image, for: .normal)

        // Navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Asset.Icons.testImage.image,
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
    }

    @objc func backTapped() {
        // Handle action
    }
}
```

#### Image Usage (SwiftUI)

```swift
import SwiftUI

struct ImageExamplesView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Direct image
            Image(asset: Asset.Icons.testImage)
                .resizable()
                .frame(width: 50, height: 50)

            // As button
            Button(action: { print("Tapped") }) {
                Image(asset: Asset.Icons.testImage)
                    .renderingMode(.template)
                    .foregroundColor(.blue)
            }

            // With label
            Label {
                Text("Icon Label")
            } icon: {
                Image(asset: Asset.Icons.testImage)
            }
        }
    }
}
```

---

## Localized Strings

### Simple Strings

```swift
import UIKit

class StringExamplesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Simple localized strings
        title = L10n.appName

        let welcomeLabel = UILabel()
        welcomeLabel.text = L10n.welcomeTitle

        let messageLabel = UILabel()
        messageLabel.text = L10n.welcomeMessage

        // Button titles
        let okButton = UIButton(type: .system)
        okButton.setTitle(L10n.buttonOk, for: .normal)

        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle(L10n.buttonCancel, for: .normal)
    }
}
```

### Strings with Parameters

```swift
import Foundation

class LocalizationExamples {
    func greetUser(name: String) -> String {
        // Single parameter
        return L10n.userGreeting(name)
        // Output: "Hello, John!"
    }

    func showItemCount(count: Int) -> String {
        // Integer parameter
        return L10n.itemsCount(count)
        // Output: "You have 5 items"
    }

    func showUserItems(username: String, itemCount: Int) -> String {
        // Multiple parameters
        return L10n.userItems(username, itemCount)
        // Output: "Alice has 10 items"
    }
}
```

### Alert Dialogs

```swift
import UIKit

extension UIViewController {
    func showSuccessAlert() {
        let alert = UIAlertController(
            title: L10n.alertTitle,
            message: L10n.successSaved,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: L10n.buttonOk,
            style: .default
        ))

        present(alert, animated: true)
    }

    func showErrorAlert(error: Error) {
        let alert = UIAlertController(
            title: L10n.alertTitle,
            message: L10n.errorUnknown,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: L10n.buttonOk,
            style: .default
        ))

        present(alert, animated: true)
    }
}
```

### SwiftUI Localization

```swift
import SwiftUI

struct LocalizedView: View {
    let username: String
    let itemCount: Int

    var body: some View {
        VStack(spacing: 16) {
            Text(L10n.welcomeTitle)
                .font(.title)

            Text(L10n.welcomeMessage)
                .font(.body)

            Text(L10n.userGreeting(username))
                .font(.headline)

            Text(L10n.userItems(username, itemCount))
                .font(.subheadline)
                .foregroundColor(.secondary)

            HStack {
                Button(L10n.buttonSave) {
                    // Save action
                }

                Button(L10n.buttonCancel) {
                    // Cancel action
                }
            }
        }
        .padding()
    }
}
```

---

## Custom Fonts

### Font Usage (UIKit)

```swift
import UIKit

class FontExamplesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Regular font
        let regularLabel = UILabel()
        regularLabel.font = FontFamily.Inter.regular.font(size: 16)
        regularLabel.text = "Regular Text"

        // Bold font
        let boldLabel = UILabel()
        boldLabel.font = FontFamily.Inter.bold.font(size: 20)
        boldLabel.text = "Bold Text"

        // SemiBold font
        let semiBoldLabel = UILabel()
        semiBoldLabel.font = FontFamily.Inter.semiBold.font(size: 18)
        semiBoldLabel.text = "SemiBold Text"

        // Button with custom font
        let button = UIButton(type: .system)
        button.titleLabel?.font = FontFamily.Inter.bold.font(size: 17)
        button.setTitle("Custom Font Button", for: .normal)
    }
}
```

### Font Usage (SwiftUI)

```swift
import SwiftUI

struct FontExamplesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Regular Font")
                .font(Font(FontFamily.Inter.regular.font(size: 16)))

            Text("Bold Font")
                .font(Font(FontFamily.Inter.bold.font(size: 20)))

            Text("SemiBold Font")
                .font(Font(FontFamily.Inter.semiBold.font(size: 18)))
        }
        .padding()
    }
}
```

### Custom Font Extension (SwiftUI)

```swift
import SwiftUI

extension Font {
    static func interRegular(size: CGFloat) -> Font {
        Font(FontFamily.Inter.regular.font(size: size))
    }

    static func interBold(size: CGFloat) -> Font {
        Font(FontFamily.Inter.bold.font(size: size))
    }

    static func interSemiBold(size: CGFloat) -> Font {
        Font(FontFamily.Inter.semiBold.font(size: size))
    }
}

// Usage
struct StyledText: View {
    var body: some View {
        VStack {
            Text("Title").font(.interBold(size: 24))
            Text("Subtitle").font(.interSemiBold(size: 18))
            Text("Body").font(.interRegular(size: 16))
        }
    }
}
```

---

## Plist Files

### Configuration Access

```swift
import Foundation

class AppConfiguration {
    // API Configuration
    static var apiBaseURL: String {
        PlistFiles.AppConfiguration.apiBaseURL
    }

    static var apiVersion: String {
        PlistFiles.AppConfiguration.apiVersion
    }

    static var enableLogging: Bool {
        PlistFiles.AppConfiguration.enableLogging
    }

    static var maxRetryAttempts: Int {
        PlistFiles.AppConfiguration.maxRetryAttempts
    }

    static var timeoutInterval: TimeInterval {
        PlistFiles.AppConfiguration.timeoutInterval
    }

    // Feature Flags
    static var isDarkModeEnabled: Bool {
        PlistFiles.AppConfiguration.featureFlags.enableDarkMode
    }

    static var areNotificationsEnabled: Bool {
        PlistFiles.AppConfiguration.featureFlags.enableNotifications
    }
}

// Usage
class NetworkManager {
    private let baseURL: URL

    init() {
        guard let url = URL(string: AppConfiguration.apiBaseURL) else {
            fatalError("Invalid API URL")
        }
        self.baseURL = url
    }

    func configure() {
        print("API Version: \(AppConfiguration.apiVersion)")
        print("Logging: \(AppConfiguration.enableLogging)")
        print("Max Retries: \(AppConfiguration.maxRetryAttempts)")
    }
}
```

---

## UIKit Examples

### Complete View Controller

```swift
import UIKit

class DemoViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Inter.bold.font(size: 24)
        label.textColor = Asset.Colors.textPrimary.color
        label.text = L10n.demoColorsTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Inter.regular.font(size: 16)
        label.textColor = Asset.Colors.textSecondary.color
        label.text = L10n.demoColorsDescription
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: Asset.Icons.testImage.image)
        imageView.tintColor = Asset.Colors.primaryColor.color
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.buttonSave, for: .normal)
        button.titleLabel?.font = FontFamily.Inter.semiBold.font(size: 17)
        button.backgroundColor = Asset.Colors.primaryColor.color
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = Asset.Colors.backgroundPrimary.color

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(iconImageView)
        view.addSubview(actionButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            iconImageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),

            actionButton.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 40),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func actionTapped() {
        let alert = UIAlertController(
            title: L10n.alertTitle,
            message: L10n.successSaved,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: L10n.buttonOk, style: .default))
        present(alert, animated: true)
    }
}
```

---

## SwiftUI Examples

### Complete SwiftUI View

```swift
import SwiftUI

struct DemoView: View {
    @State private var showAlert = false
    @State private var username = "John"
    @State private var itemCount = 5

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                headerSection

                // Colors Demo
                colorsSection

                // Images Demo
                imagesSection

                // Fonts Demo
                fontsSection

                // Actions
                actionsSection
            }
            .padding()
        }
        .background(Asset.Colors.backgroundPrimary.swiftUIColor)
        .alert(L10n.alertTitle, isPresented: $showAlert) {
            Button(L10n.buttonOk, role: .cancel) { }
        } message: {
            Text(L10n.successSaved)
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text(L10n.welcomeTitle)
                .font(.interBold(size: 28))
                .foregroundColor(Asset.Colors.textPrimary.swiftUIColor)

            Text(L10n.welcomeMessage)
                .font(.interRegular(size: 16))
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
                .multilineTextAlignment(.center)
        }
    }

    private var colorsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.demoColorsTitle)
                .font(.interSemiBold(size: 20))

            HStack(spacing: 12) {
                ColorCircle(color: Asset.Colors.primaryColor.swiftUIColor, name: "Primary")
                ColorCircle(color: Asset.Colors.successColor.swiftUIColor, name: "Success")
                ColorCircle(color: Asset.Colors.errorColor.swiftUIColor, name: "Error")
                ColorCircle(color: Asset.Colors.warningColor.swiftUIColor, name: "Warning")
            }
        }
    }

    private var imagesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Images")
                .font(.interSemiBold(size: 20))

            Image(asset: Asset.Icons.testImage)
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(Asset.Colors.primaryColor.swiftUIColor)
        }
    }

    private var fontsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.demoFontsTitle)
                .font(.interSemiBold(size: 20))

            Text("Regular Font")
                .font(.interRegular(size: 16))

            Text("SemiBold Font")
                .font(.interSemiBold(size: 16))

            Text("Bold Font")
                .font(.interBold(size: 16))
        }
    }

    private var actionsSection: some View {
        VStack(spacing: 16) {
            Button(action: { showAlert = true }) {
                Text(L10n.buttonSave)
                    .font(.interSemiBold(size: 17))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Asset.Colors.primaryColor.swiftUIColor)
                    .cornerRadius(8)
            }

            Text(L10n.userGreeting(username))
                .font(.interRegular(size: 14))

            Text(L10n.itemsCount(itemCount))
                .font(.interRegular(size: 14))
        }
    }
}

struct ColorCircle: View {
    let color: Color
    let name: String

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 50, height: 50)

            Text(name)
                .font(.interRegular(size: 12))
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
        }
    }
}
```

---

## Common Patterns

### Theme Manager

```swift
import UIKit

struct AppTheme {
    // Colors
    static let primaryColor = Asset.Colors.primaryColor.color
    static let secondaryColor = Asset.Colors.secondaryColor.color
    static let backgroundColor = Asset.Colors.backgroundPrimary.color
    static let textPrimaryColor = Asset.Colors.textPrimary.color
    static let textSecondaryColor = Asset.Colors.textSecondary.color

    // Fonts
    static func titleFont(size: CGFloat = 24) -> UIFont {
        FontFamily.Inter.bold.font(size: size)
    }

    static func headlineFont(size: CGFloat = 18) -> UIFont {
        FontFamily.Inter.semiBold.font(size: size)
    }

    static func bodyFont(size: CGFloat = 16) -> UIFont {
        FontFamily.Inter.regular.font(size: size)
    }

    static func captionFont(size: CGFloat = 12) -> UIFont {
        FontFamily.Inter.regular.font(size: size)
    }
}

// Usage
let label = UILabel()
label.font = AppTheme.titleFont()
label.textColor = AppTheme.textPrimaryColor
```

### Type-Safe Image Loading

```swift
import UIKit

extension UIImageView {
    func setImage(_ asset: ImageAsset, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.image = asset.image
        self.contentMode = contentMode
    }
}

// Usage
let imageView = UIImageView()
imageView.setImage(Asset.Icons.testImage)
```

### Configuration Service

```swift
import Foundation

class ConfigurationService {
    static let shared = ConfigurationService()

    private init() {}

    var apiConfiguration: APIConfiguration {
        APIConfiguration(
            baseURL: PlistFiles.AppConfiguration.apiBaseURL,
            version: PlistFiles.AppConfiguration.apiVersion,
            timeout: PlistFiles.AppConfiguration.timeoutInterval,
            maxRetries: PlistFiles.AppConfiguration.maxRetryAttempts,
            loggingEnabled: PlistFiles.AppConfiguration.enableLogging
        )
    }

    var appInfo: AppInfo {
        AppInfo(
            name: PlistFiles.AppSettings.appName,
            version: PlistFiles.AppSettings.version,
            buildNumber: PlistFiles.AppSettings.buildNumber,
            supportEmail: PlistFiles.AppSettings.supportEmail
        )
    }
}

struct APIConfiguration {
    let baseURL: String
    let version: String
    let timeout: TimeInterval
    let maxRetries: Int
    let loggingEnabled: Bool
}

struct AppInfo {
    let name: String
    let version: String
    let buildNumber: Int
    let supportEmail: String
}
```

---

## Migration Guide

### From String Literals

**Before:**
```swift
let color = UIColor(named: "PrimaryColor")
let image = UIImage(named: "icon-home")
let text = NSLocalizedString("welcome_message", comment: "")
```

**After:**
```swift
let color = Asset.Colors.primaryColor.color
let image = Asset.Icons.iconHome.image
let text = L10n.welcomeMessage
```

### From R.swift

If migrating from R.swift:

```swift
// R.swift
let color = R.color.primaryColor()!
let image = R.image.iconHome()!
let text = R.string.localizable.welcomeMessage()

// SwiftGen
let color = Asset.Colors.primaryColor.color
let image = Asset.Icons.iconHome.image
let text = L10n.welcomeMessage
```

---

For more examples, check the demo app source code or visit the [official SwiftGen documentation](https://github.com/SwiftGen/SwiftGen).
