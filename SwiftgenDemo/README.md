# SwiftGen Demo

A comprehensive demonstration project showcasing [SwiftGen](https://github.com/SwiftGen/SwiftGen), a tool that automatically generates Swift code for your resources to make them type-safe.

## What is SwiftGen?

SwiftGen is a command-line tool that generates type-safe Swift code for your project resources (colors, images, fonts, localized strings, plists, and more). This eliminates the common problem of typos in resource names that only surface at runtime.

### Benefits of Using SwiftGen

✅ **Type Safety**: Compile-time errors instead of runtime crashes
✅ **Autocomplete**: Xcode suggests available resources as you type
✅ **Refactoring**: Rename resources safely with Find & Replace
✅ **Discoverability**: Browse all available resources through code
✅ **Maintainability**: Centralized resource management
✅ **No Magic Strings**: Eliminate hardcoded resource names

## Demo Features

This project demonstrates SwiftGen integration with:

- **Asset Catalogs**: Colors, images, and icons with organized namespaces
- **Localized Strings**: Type-safe string localization with parameter substitution
- **Custom Fonts**: Type-safe access to custom font families
- **Plist Files**: Configuration and settings with compile-time validation
- **Xcode Integration**: Build phase automation

## Installation

### System-wide Installation (Recommended)

Install SwiftGen using Homebrew for system-wide availability:

```bash
brew update
brew install swiftgen
```

Verify installation:

```bash
swiftgen --version
```

### Alternative Installation Methods

<details>
<summary>CocoaPods</summary>

Add to your `Podfile`:

```ruby
pod 'SwiftGen', '~> 6.0'
```

Then run:

```bash
pod install
```

Use in build phase:

```bash
"${PODS_ROOT}/SwiftGen/bin/swiftgen"
```
</details>

<details>
<summary>Mint</summary>

```bash
mint install SwiftGen/SwiftGen
```
</details>

<details>
<summary>Manual Installation</summary>

Download the latest release from [GitHub](https://github.com/SwiftGen/SwiftGen/releases) and place the binary in your project or `$PATH`.
</details>

## Project Structure

```
SwiftgenDemo/
├── swiftgen.yml                           # SwiftGen configuration
├── SwiftgenDemo/
│   ├── SupportingFiles/
│   │   ├── Assets/
│   │   │   ├── Colors.xcassets           # Color assets
│   │   │   ├── Icons.xcassets            # Icon assets
│   │   │   └── Images.xcassets           # Image assets
│   │   ├── Fonts/
│   │   │   ├── Inter-Regular.ttf         # Custom fonts
│   │   │   ├── Inter-Bold.ttf
│   │   │   └── Inter-SemiBold.ttf
│   │   ├── Localization/
│   │   │   └── Localizable.xcstrings     # Localized strings
│   │   ├── Plists/
│   │   │   ├── AppConfiguration.plist    # App configuration
│   │   │   └── AppSettings.plist         # App settings
│   │   └── Generated/                     # Generated Swift files
│   │       ├── XCassets+Generated.swift
│   │       ├── Strings+Generated.swift
│   │       ├── Fonts+Generated.swift
│   │       └── Plists+Generated.swift
```

## Configuration

The `swiftgen.yml` file configures all resource parsers. Here's what each section does:

### Asset Catalogs (Colors, Images, Icons)

```yaml
xcassets:
  inputs:
    - SupportingFiles/Assets/
  outputs:
    - templateName: swift5
      params:
        forceProvidesNamespaces: true
        allValues: true
      output: XCassets+Generated.swift
```

### Localized Strings

```yaml
strings:
  inputs:
    - SupportingFiles/Localization/Localizable.xcstrings
  outputs:
    - templateName: structured-swift5
      params:
        enumName: L10n
      output: Strings+Generated.swift
```

### Custom Fonts

```yaml
fonts:
  inputs:
    - SupportingFiles/Fonts
  outputs:
    - templateName: swift5
      output: Fonts+Generated.swift
```

### Plist Files

```yaml
plist:
  inputs:
    - SupportingFiles/Plists
  outputs:
    - templateName: inline-swift5
      output: Plists+Generated.swift
```

## Usage Examples

### Before SwiftGen (Error-Prone ❌)

```swift
// Typos cause runtime crashes
let color = UIColor(named: "PrimaryColr")  // nil!
let image = UIImage(named: "btnIcon")      // renamed, nil!
let text = NSLocalizedString("welcme.message", comment: "")  // typo

// No autocomplete, no compiler help
```

### After SwiftGen (Type-Safe ✅)

#### Colors

```swift
import UIKit

// UIKit
let primaryColor = Asset.Colors.primaryColor.color
let errorColor = Asset.Colors.errorColor.color

// SwiftUI
import SwiftUI
let bgColor = Asset.Colors.backgroundPrimary.swiftUIColor

// Compile error if color doesn't exist!
```

#### Images

```swift
import UIKit

// UIKit
let icon = Asset.Icons.testImage.image

// SwiftUI
import SwiftUI
Image(asset: Asset.Icons.testImage)

// Autocomplete shows all available images
```

#### Localized Strings

```swift
// Simple strings
let title = L10n.welcomeTitle
let message = L10n.welcomeMessage

// Strings with parameters
let greeting = L10n.userGreeting("John")
let count = L10n.itemsCount(5)
let userItems = L10n.userItems("Alice", 10)

// Compile-time validation of format specifiers
```

#### Custom Fonts

```swift
import UIKit

// UIKit
let regularFont = FontFamily.Inter.regular.font(size: 16)
let boldFont = FontFamily.Inter.bold.font(size: 20)
let semiBoldFont = FontFamily.Inter.semiBold.font(size: 18)

// SwiftUI
Text("Hello")
    .font(Font(FontFamily.Inter.regular.font(size: 16)))

// Autocomplete shows all available fonts and weights
```

#### Plist Configuration

```swift
// Type-safe plist access
let apiURL = PlistFiles.AppConfiguration.apiBaseURL
let version = PlistFiles.AppSettings.version
let enableLogging = PlistFiles.AppConfiguration.enableLogging

// Values are embedded at compile time (inline template)
```

## Running the Demo

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd SwiftgenDemo
   ```

2. **Install SwiftGen** (if not already installed):
   ```bash
   brew install swiftgen
   ```

3. **Generate resource files** (optional, done automatically on build):
   ```bash
   swiftgen config run --config swiftgen.yml
   ```

4. **Open the project**:
   ```bash
   open SwiftgenDemo.xcodeproj
   ```

5. **Build and run** (⌘R)

The app will build and automatically generate all resource files via the Run Script build phase.

## Xcode Integration

SwiftGen is integrated into the Xcode build process via a Run Script Phase:

```bash
if [[ "$(uname -m)" == arm64 ]]
then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if command -v swiftgen >/dev/null 2>&1
then
    swiftgen config run
else
    echo "warning: swiftgen command not found"
fi
```

This ensures:
- Generated files are always up to date
- Team members without SwiftGen installed see a warning (not an error)
- Works on both Intel and Apple Silicon Macs

## Validation

Verify your SwiftGen configuration:

```bash
# Validate configuration syntax
swiftgen config lint

# Test generation without writing files
swiftgen config run --dry-run
```

## Comparing Approaches

| Approach | Type Safety | Autocomplete | Refactoring | Runtime Safety |
|----------|-------------|--------------|-------------|----------------|
| **String Literals** | ❌ | ❌ | ❌ | ❌ |
| **Constants File** | ⚠️ Partial | ✅ | ✅ | ⚠️ Partial |
| **SwiftGen** | ✅ | ✅ | ✅ | ✅ |

## Best Practices

1. **Organize Assets**: Use separate `.xcassets` for Colors, Icons, and Images
2. **Namespace Everything**: Enable `forceProvidesNamespaces` for better organization
3. **Commit Generated Files**: Include generated Swift files in version control
4. **Run on Every Build**: Integrate SwiftGen into Xcode build phases
5. **Validate Configuration**: Use `swiftgen config lint` before committing
6. **Document Custom Templates**: If using custom templates, document modifications

## Common Issues & Solutions

### Issue: "warning: swiftgen command not found"

**Solution**: Install SwiftGen using Homebrew:
```bash
brew install swiftgen
```

### Issue: Generated files not updating

**Solution**: Clean build folder (⌘⇧K) and rebuild:
```bash
# Or from command line
xcodebuild clean
xcodebuild build
```

### Issue: "File not found" errors for generated files

**Solution**: Ensure generated files are added to your Xcode project target.

### Issue: Fonts not appearing in app

**Solution**:
1. Verify fonts are in `UIAppFonts` in Info.plist
2. Ensure font files are added to app target (Build Phases > Copy Bundle Resources)
3. Check font file names match exactly (case-sensitive)

## Template Customization

SwiftGen uses Stencil templates for code generation. View available templates:

```bash
# List templates for a parser
swiftgen template list xcassets

# View template documentation
swiftgen template doc xcassets swift5

# Use custom template
swiftgen run xcassets --templatePath MyCustomTemplate.stencil
```

## Additional Resources

- [Official SwiftGen Documentation](https://github.com/SwiftGen/SwiftGen)
- [SwiftGen Templates](https://github.com/SwiftGen/SwiftGen/tree/stable/Documentation/templates)
- [Custom Templates Guide](https://github.com/SwiftGen/SwiftGen/blob/stable/Documentation/Articles/Creating-custom-templates.md)
- [SETUP.md](SETUP.md): Step-by-step integration guide
- [EXAMPLES.md](EXAMPLES.md): More code examples and patterns

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to improve this demo.

## License

This project is available under the MIT License.

## Credits

- SwiftGen: [https://github.com/SwiftGen/SwiftGen](https://github.com/SwiftGen/SwiftGen)
- Inter Font: [Google Fonts](https://fonts.google.com/specimen/Inter)