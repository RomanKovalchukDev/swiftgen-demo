# SwiftGen Demo

A comprehensive demonstration of [SwiftGen](https://github.com/SwiftGen/SwiftGen) integration in a production-style iOS application. This project showcases type-safe access to app resources including strings, colors, images, fonts, and configuration files.

## Overview

SwiftGen is a code generation tool that creates Swift enums and structs from your project resources. This eliminates runtime errors from typos in resource names and provides compile-time safety and autocompletion for all your assets.

## Features Demonstrated

This demo project illustrates SwiftGen integration for:

- **Localized Strings**: Type-safe access to `Localizable.strings` with parameter support
- **Asset Catalogs**: Compile-time validated colors and images from `.xcassets`
- **Custom Fonts**: Type-safe font family and weight access
- **Plist Files**: Generated constants for configuration files

### Without SwiftGen vs With SwiftGen

```swift
// ❌ Without SwiftGen (runtime errors possible)
let title = NSLocalizedString("welcome.title", comment: "")
let color = UIColor(named: "PrimaryColor") // Returns nil if typo
let image = UIImage(named: "TestImage") // Returns nil if renamed
let font = UIFont(name: "Inter-Bold", size: 16) // Falls back to system font

// ✅ With SwiftGen (compile-time safety)
let title = L10n.Welcome.title
let color = Asset.Colors.primaryColor.color
let image = Asset.Icons.testImage.image
let font = FontFamily.Inter.bold.font(size: 16)
```

## Requirements

- Xcode 14.0+
- iOS 15.0+
- Swift 5.7+
- SwiftGen 6.6.0+ (install via Homebrew or Mint)

## Installation

### 1. Install SwiftGen

Using Homebrew:
```bash
brew install swiftgen
```

Using Mint:
```bash
mint install SwiftGen/SwiftGen
```

### 2. Clone and Build

```bash
git clone <repository-url>
cd swiftgen-demo
cd SwiftgenDemo
xcodebuild -scheme "SwiftgenDemo-Dev" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 16' clean build -quiet
```

## Project Structure

```
SwiftgenDemo/
├── SwiftgenDemo/
│   ├── BusinessLayer/           # Services and business logic
│   ├── DataLayer/               # Networking and repositories
│   ├── PresentationLayer/       # SwiftUI views and navigation
│   └── SupportingFiles/
│       ├── Assets/              # Asset catalogs (colors, images)
│       ├── Fonts/               # Custom font files (.ttf, .otf)
│       ├── Localization/        # Localizable.strings files
│       ├── Plists/              # Configuration plist files
│       └── Generated/           # SwiftGen generated code
│           ├── XCassets+Generated.swift
│           ├── Strings+Generated.swift
│           ├── Fonts+Generated.swift
│           └── Plists+Generated.swift
└── swiftgen.yml                 # SwiftGen configuration
```

## SwiftGen Configuration

The `swiftgen.yml` file configures resource parsing:

### Asset Catalogs
Generates namespaced enums for all images and colors in `Assets.xcassets`:
```yaml
xcassets:
  inputs:
    - SupportingFiles/Assets/
  outputs:
    - templateName: swift5
      output: XCassets+Generated.swift
```

### Localized Strings
Creates structured enums from `Localizable.strings`:
```yaml
strings:
  inputs:
    - SupportingFiles/Localization/en.lproj
  outputs:
    - templateName: structured-swift5
      params:
        enumName: L10n
      output: Strings+Generated.swift
```

### Fonts
Generates type-safe access to custom fonts:
```yaml
fonts:
  inputs:
    - SupportingFiles/Fonts
  outputs:
    - templateName: swift5
      output: Fonts+Generated.swift
```

### Plists
Embeds plist data as Swift constants:
```yaml
plist:
  inputs:
    - SupportingFiles/Plists
  outputs:
    - templateName: inline-swift5
      output: Plists+Generated.swift
```

## Generating Code

### Manual Generation

From the project directory:
```bash
cd SwiftgenDemo
swiftgen
```

### Build Phase Integration

Add a Run Script phase in Xcode to regenerate code automatically:

1. Select your target in Xcode
2. Go to Build Phases
3. Add a new Run Script Phase
4. Add this script:
```bash
if which swiftgen >/dev/null; then
  swiftgen
else
  echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
fi
```
5. Move the script phase before "Compile Sources"

## Usage Examples

### Localized Strings

**Localizable.strings:**
```
"welcome.title" = "Welcome to SwiftGen";
"user.greeting" = "Hello, %@!";
```

**Swift code:**
```swift
// Simple string
let title = L10n.Welcome.title

// String with parameters
let greeting = L10n.User.greeting("John")
```

### Colors and Images

```swift
// Colors
let primaryColor = Asset.Colors.primaryColor.swiftUIColor
let backgroundColor = Asset.Colors.backgroundPrimary.color

// Images
let icon = Asset.Icons.testImage.swiftUIImage
let uiImage = Asset.Icons.testImage.image
```

### Fonts

```swift
// SwiftUI
Text("Hello")
    .font(FontFamily.Inter.bold.swiftUIFont(size: 20))

// UIKit
let font = FontFamily.Inter.semiBold.font(size: 16)
```

### Plists

**AppConfiguration.plist:**
```xml
<dict>
    <key>APIBaseURL</key>
    <string>https://api.example.com</string>
    <key>EnableLogging</key>
    <true/>
</dict>
```

**Swift code:**
```swift
let apiURL = PlistFiles.AppConfiguration.apiBaseURL
let loggingEnabled = PlistFiles.AppConfiguration.enableLogging
```

## Running the Demo App

1. Open `SwiftgenDemo.xcodeproj` in Xcode
2. Select a simulator or device
3. Build and run (⌘R)

The demo app displays interactive examples of all SwiftGen features with side-by-side code comparisons.

## Benefits

### Compile-Time Safety
All resource access is validated at compile time. Renamed or deleted assets cause build errors instead of runtime crashes.

### Autocompletion
Xcode provides full autocomplete for all resources, improving developer productivity.

### Refactoring Support
Renaming resources through Xcode's refactoring tools updates all references automatically.

### Type Safety
Eliminates string-based lookups and provides strongly typed APIs for all resources.

### Documentation
Generated code includes inline documentation with original resource names and metadata.

## Advanced Configuration

### Custom Templates

SwiftGen supports custom Stencil templates for specialized code generation. View available templates:
```bash
swiftgen template list
```

Generate documentation for a specific template:
```bash
swiftgen template doc strings structured-swift5
```

### Multiple Outputs

Generate separate files for different resource groups:
```yaml
xcassets:
  inputs:
    - SupportingFiles/Assets/Colors.xcassets
    - SupportingFiles/Assets/Images.xcassets
  outputs:
    - templateName: swift5
      params:
        forceProvidesNamespaces: true
      output: Colors+Generated.swift
      filter: .*/Colors/.*
    - templateName: swift5
      output: Images+Generated.swift
      filter: .*/Images/.*
```

### Validation

Validate your configuration file:
```bash
swiftgen config lint
```

## Architecture

This project follows a clean layered architecture:

- **Presentation Layer**: SwiftUI views and view models
- **Business Layer**: Services and business logic (Analytics, etc.)
- **Data Layer**: Networking, repositories, and data models

The generated SwiftGen code is accessed throughout all layers, demonstrating integration in a production environment.

## Contributing

Contributions are welcome. When adding new examples:

1. Add the resource to the appropriate directory (Assets, Localization, etc.)
2. Run `swiftgen` to regenerate code
3. Add usage examples to `SwiftGenDemoView.swift`
4. Ensure the app builds and runs correctly

## Resources

- [SwiftGen Documentation](https://github.com/SwiftGen/SwiftGen)
- [SwiftGen Templates](https://github.com/SwiftGen/SwiftGen#available-templates)
- [Stencil Template Language](https://stencil.fuller.li/)

## License

This demo project is provided as-is for educational purposes.
