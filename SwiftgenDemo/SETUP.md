# SwiftGen Integration Setup Guide

This guide walks you through integrating SwiftGen into your own iOS project from scratch.

## Prerequisites

- Xcode 14.0 or later
- iOS 15.0+ target
- Homebrew (for system-wide installation)

## Step 1: Install SwiftGen

### Option A: System-wide Installation (Recommended)

```bash
brew update
brew install swiftgen
```

Verify installation:

```bash
swiftgen --version
```

### Option B: Per-project Installation

**Via CocoaPods:**

Add to your `Podfile`:

```ruby
pod 'SwiftGen', '~> 6.0'
```

Then run:

```bash
pod install
```

## Step 2: Create Configuration File

Navigate to your project root and create `swiftgen.yml`:

```bash
cd /path/to/your/project
touch swiftgen.yml
```

## Step 3: Configure Basic Setup

Start with a minimal configuration. Open `swiftgen.yml` and add:

```yaml
input_dir: YourProjectName/
output_dir: YourProjectName/Generated/

xcassets:
  inputs:
    - Resources/Assets.xcassets
  outputs:
    - templateName: swift5
      output: Assets+Generated.swift
```

Adjust paths to match your project structure.

## Step 4: Create Generated Files Directory

Create the directory for generated files:

```bash
mkdir -p YourProjectName/Generated
```

## Step 5: Run SwiftGen

Generate your first files:

```bash
swiftgen config run --config swiftgen.yml
```

If successful, you'll see:

```
Executing configuration file swiftgen.yml
File written: YourProjectName/Generated/Assets+Generated.swift
```

## Step 6: Add Generated Files to Xcode

1. Open your Xcode project
2. Right-click on your project navigator
3. Select "Add Files to [ProjectName]"
4. Navigate to the `Generated` folder
5. Select all `.swift` files
6. Ensure "Copy items if needed" is **unchecked**
7. Select your app target
8. Click "Add"

⚠️ **Important**: Do not check "Copy items if needed". Generated files should stay in their original location.

## Step 7: Integrate with Xcode Build Phase

### Add Run Script Phase

1. Select your project in Xcode
2. Select your app target
3. Go to "Build Phases" tab
4. Click "+" button → "New Run Script Phase"
5. Name it "Run SwiftGen"
6. Drag it **before** "Compile Sources" phase
7. Add the following script:

```bash
if [[ "$(uname -m)" == arm64 ]]
then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if command -v swiftgen >/dev/null 2>&1
then
    swiftgen config run --config "${PROJECT_DIR}/swiftgen.yml"
else
    echo "warning: swiftgen command not found. Install it with 'brew install swiftgen'"
fi
```

### Script Explanation

- **Path setup**: Ensures SwiftGen is found on Apple Silicon Macs
- **Command check**: Warns if SwiftGen isn't installed (doesn't fail the build)
- **Config path**: Uses `$PROJECT_DIR` to find config file

## Step 8: Configure Additional Parsers

### Strings

Add to `swiftgen.yml`:

```yaml
strings:
  inputs:
    - Resources/Localizable.xcstrings
  outputs:
    - templateName: structured-swift5
      params:
        enumName: L10n
      output: Strings+Generated.swift
```

### Fonts

1. Add custom fonts to your project
2. Update `Info.plist`:

```xml
<key>UIAppFonts</key>
<array>
    <string>YourFont-Regular.ttf</string>
    <string>YourFont-Bold.ttf</string>
</array>
```

3. Add to `swiftgen.yml`:

```yaml
fonts:
  inputs:
    - Resources/Fonts
  outputs:
    - templateName: swift5
      output: Fonts+Generated.swift
```

### Plists

Add to `swiftgen.yml`:

```yaml
plist:
  inputs:
    - Resources/Config
  outputs:
    - templateName: inline-swift5
      output: Plists+Generated.swift
```

## Step 9: Organize Your Assets

### Recommended Structure

```
YourProjectName/
├── Resources/
│   ├── Assets.xcassets/
│   │   ├── Colors.xcassets
│   │   ├── Icons.xcassets
│   │   └── Images.xcassets
│   ├── Fonts/
│   │   ├── CustomFont-Regular.ttf
│   │   └── CustomFont-Bold.ttf
│   ├── Localization/
│   │   └── Localizable.xcstrings
│   └── Config/
│       └── Settings.plist
├── Generated/
│   ├── Assets+Generated.swift
│   ├── Strings+Generated.swift
│   ├── Fonts+Generated.swift
│   └── Plists+Generated.swift
```

### Asset Catalog Organization

In Xcode, create separate asset catalogs:

1. Right-click in Project Navigator
2. New File → Asset Catalog
3. Name it (e.g., "Colors", "Icons", "Images")
4. Check "Provides Namespace" for folder organization

## Step 10: Validate Configuration

Test your setup:

```bash
# Validate syntax
swiftgen config lint

# Dry run (no file changes)
swiftgen config run --dry-run

# Verbose output
swiftgen config run --verbose
```

## Step 11: Update .gitignore (Optional)

Some teams prefer to **not** commit generated files:

```gitignore
# SwiftGen Generated Files
**/Generated/
```

However, **committing generated files is recommended** because:
- Ensures build works without SwiftGen installed
- Provides code review visibility
- Avoids merge conflicts from regeneration

## Step 12: First Usage

Replace string literals with type-safe accessors:

**Before:**

```swift
let color = UIColor(named: "PrimaryColor")
let text = NSLocalizedString("welcome.message", comment: "")
```

**After:**

```swift
let color = Asset.Colors.primaryColor.color
let text = L10n.welcomeMessage
```

Build your project (⌘B). SwiftGen will run automatically and regenerate files if resources changed.

## Common Issues & Solutions

### Issue: "Command not found" error

**Cause**: SwiftGen not in PATH or not installed

**Solution**:
```bash
# Check installation
which swiftgen

# If not found, install
brew install swiftgen

# Verify Homebrew path (Apple Silicon)
echo $PATH | grep homebrew
```

### Issue: Generated files not found in Xcode

**Cause**: Files not added to target or incorrect path

**Solution**:
1. Verify files exist: `ls -la YourProjectName/Generated/`
2. In Xcode, select generated file
3. Check "Target Membership" in File Inspector
4. Ensure your app target is checked

### Issue: "No such file or directory" when building

**Cause**: Generated directory doesn't exist

**Solution**:
```bash
mkdir -p YourProjectName/Generated
swiftgen config run
```

### Issue: Changes to resources not reflected

**Cause**: SwiftGen not running or files not regenerating

**Solution**:
1. Clean build folder (⌘⇧K)
2. Manually run: `swiftgen config run`
3. Verify Run Script Phase order (before Compile Sources)

### Issue: Fonts not appearing in app

**Cause**: Font files not in bundle or missing from Info.plist

**Solution**:
1. Select font files in Xcode
2. Check "Target Membership" → ensure app target is selected
3. Verify Build Phases → Copy Bundle Resources includes fonts
4. Verify Info.plist contains `UIAppFonts` array with exact font filenames

## Best Practices

### 1. Run Script Phase Order

```
1. Run SwiftGen
2. Compile Sources
3. Other build phases
```

### 2. Configuration Organization

Use comments in `swiftgen.yml`:

```yaml
## Colors, Images, Icons
xcassets:
  inputs:
    - Resources/Assets/
  outputs:
    - templateName: swift5
      params:
        forceProvidesNamespaces: true  # Creates namespaces per folder
      output: Assets+Generated.swift
```

### 3. Input Path Organization

Group resources by type:

```yaml
xcassets:
  inputs:
    - Resources/Colors.xcassets
    - Resources/Icons.xcassets
    - Resources/Images.xcassets
```

### 4. Template Parameters

Explore available parameters:

```bash
swiftgen template doc xcassets swift5
```

Common parameters:
- `forceProvidesNamespaces`: Creates namespaces for folders
- `allValues`: Generates arrays of all assets (deprecated)
- `publicAccess`: Makes generated code public

### 5. Multiple Targets

For multi-target projects:

```yaml
xcassets:
  inputs:
    - AppName/Assets.xcassets
  outputs:
    - templateName: swift5
      output: AppName/Generated/Assets+Generated.swift
    - templateName: swift5
      params:
        publicAccess: true
      output: Framework/Generated/Assets+Generated.swift
```

## Advanced Configuration

### Custom Templates

Create custom Stencil template:

1. Create `MyTemplate.stencil`
2. Reference in config:

```yaml
xcassets:
  inputs:
    - Resources/Assets.xcassets
  outputs:
    - templatePath: CustomTemplates/MyTemplate.stencil
      output: CustomAssets.swift
```

### Environment-based Configuration

Use different configs per environment:

```bash
# Development
swiftgen config run --config swiftgen-dev.yml

# Production
swiftgen config run --config swiftgen-prod.yml
```

### Parser-specific Configuration

```yaml
xcassets:
  inputs:
    - Resources/Colors.xcassets
  filter: ^[A-Z]  # Only assets starting with capital letter
  outputs:
    - templateName: swift5
      output: Colors.swift
```

## Verification Checklist

- [ ] SwiftGen installed and in PATH
- [ ] Configuration file created (`swiftgen.yml`)
- [ ] Generated directory exists
- [ ] `swiftgen config lint` passes
- [ ] Generated files added to Xcode project
- [ ] Generated files added to target membership
- [ ] Run Script build phase configured
- [ ] Run Script phase before Compile Sources
- [ ] Build succeeds (⌘B)
- [ ] Resources accessible via generated code
- [ ] Team members can build project

## Next Steps

- Explore [Templates Documentation](https://github.com/SwiftGen/SwiftGen/tree/stable/Documentation/templates)
- Review [EXAMPLES.md](EXAMPLES.md) for usage patterns
- Check out [SwiftGen GitHub](https://github.com/SwiftGen/SwiftGen) for updates

## Troubleshooting

If you encounter issues:

1. Check SwiftGen version: `swiftgen --version`
2. Validate config: `swiftgen config lint`
3. Run manually: `swiftgen config run --verbose`
4. Review build logs in Xcode (View → Navigators → Reports)
5. Search [GitHub Issues](https://github.com/SwiftGen/SwiftGen/issues)

---

Need help? Open an issue or refer to the [official documentation](https://github.com/SwiftGen/SwiftGen/tree/stable/Documentation).
