//
//  SwiftGenDemoView.swift
//  SwiftgenDemo
//
//  SwiftUI demo showcasing SwiftGen usage
//

import SwiftUI

struct SwiftGenDemoView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {

                    // Strings Demo
                    StringsSection()

                    // Colors Demo
                    ColorsSection()

                    // Images Demo
                    ImagesSection()

                    // Fonts Demo
                    FontsSection()

                    // Plists Demo
                    PlistsSection()
                }
                .padding(20)
            }
            .background(Asset.Colors.backgroundPrimary.swiftUIColor)
            .navigationTitle(L10n.App.name)
        }
    }
}

// MARK: - Header Section

struct HeaderSection: View {
    var body: some View {
        VStack(spacing: 8) {
            Text(L10n.Welcome.title)
                .font(.custom("Inter-Bold", size: 28))
                .foregroundColor(Asset.Colors.textPrimary.swiftUIColor)

            Text(L10n.Welcome.message)
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
                .multilineTextAlignment(.center)
        }
    }
}

// MARK: - Strings Section

struct StringsSection: View {
    var body: some View {
        DemoSection(
            title: "🔤 Localized Strings",
            description: "Type-safe string localization"
        ) {
            VStack(spacing: 12) {
                ExampleCard(
                    title: "❌ Without SwiftGen",
                    code: "NSLocalizedString(\"welcome.title\", comment: \"\")",
                    result: NSLocalizedString("welcome.title", comment: "")
                )

                ExampleCard(
                    title: "✅ With SwiftGen",
                    code: "L10n.Welcome.title",
                    result: L10n.Welcome.title
                )

                ExampleCard(
                    title: "❌ With Parameters (Old)",
                    code: "String(format: NSLocalizedString(\"user.greeting\", comment: \"\"), \"John\")",
                    result: String(format: NSLocalizedString("user.greeting", comment: ""), "John")
                )

                ExampleCard(
                    title: "✅ With Parameters (SwiftGen)",
                    code: "L10n.User.greeting(\"John\")",
                    result: L10n.User.greeting("John")
                )
            }
        }
    }
}

// MARK: - Colors Section

struct ColorsSection: View {
    let colors: [(String, ColorAsset)] = [
        ("Primary", Asset.Colors.primaryColor),
        ("Success", Asset.Colors.successColor),
        ("Error", Asset.Colors.errorColor),
        ("Warning", Asset.Colors.warningColor)
    ]

    var body: some View {
        DemoSection(
            title: "🎨 Colors",
            description: "Type-safe color access"
        ) {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    ForEach(colors, id: \.0) { name, colorAsset in
                        ColorSwatch(name: name, color: colorAsset.swiftUIColor)
                    }
                }

                ExampleCard(
                    title: "❌ Without SwiftGen",
                    code: "Color(\"PrimaryColor\")",
                    result: "Returns nil if typo or renamed"
                )

                ExampleCard(
                    title: "✅ With SwiftGen",
                    code: "Asset.Colors.primaryColor.swiftUIColor",
                    result: "Compile-time error if missing"
                )
            }
        }
    }
}

// MARK: - Images Section

struct ImagesSection: View {
    var body: some View {
        DemoSection(
            title: "🖼️ Images & Icons",
            description: "Type-safe image assets"
        ) {
            VStack(spacing: 12) {
                Image(uiImage: Asset.Icons.testImage.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Asset.Colors.primaryColor.swiftUIColor)
                    .frame(height: 80)

                ExampleCard(
                    title: "❌ Without SwiftGen",
                    code: "Image(\"TestImage\")",
                    result: "Returns placeholder if renamed or deleted"
                )

                ExampleCard(
                    title: "✅ With SwiftGen",
                    code: "Asset.Icons.testImage.swiftUIImage",
                    result: "Autocomplete + compile error if missing"
                )
            }
        }
    }
}

// MARK: - Fonts Section

struct FontsSection: View {
    let fonts: [(String, String)] = [
        ("Regular", "Inter-Regular"),
        ("SemiBold", "Inter-SemiBold"),
        ("Bold", "Inter-Bold")
    ]

    var body: some View {
        DemoSection(
            title: "🔤 Custom Fonts",
            description: "Type-safe font access"
        ) {
            VStack(spacing: 12) {
                ForEach(fonts, id: \.0) { name, fontName in
                    Text("Inter \(name): The quick brown fox")
                        .font(.custom(fontName, size: 16))
                        .foregroundColor(Asset.Colors.textPrimary.swiftUIColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Divider()
                    .padding(.vertical, 4)

                ExampleCard(
                    title: "❌ Without SwiftGen",
                    code: "Font.custom(\"Inter-Bold\", size: 16)",
                    result: "Returns system font if name wrong"
                )

                ExampleCard(
                    title: "✅ With SwiftGen",
                    code: "FontFamily.Inter.bold.swiftUIFont(size: 16)",
                    result: "Autocomplete shows all weights"
                )
            }
        }
    }
}

// MARK: - Plists Section

struct PlistsSection: View {
    var body: some View {
        DemoSection(
            title: "📋 Plist Configuration",
            description: "Type-safe config file access"
        ) {
            VStack(spacing: 12) {
                ExampleCard(
                    title: "Config Values",
                    code: "PlistFiles.AppConfiguration.apiBaseURL",
                    result: PlistFiles.AppConfiguration.apiBaseURL
                )

                ExampleCard(
                    title: "App Settings",
                    code: "PlistFiles.AppSettings.appName",
                    result: PlistFiles.AppSettings.appName
                )

                ExampleCard(
                    title: "Feature Flags",
                    code: "PlistFiles.AppConfiguration.enableLogging",
                    result: "\(PlistFiles.AppConfiguration.enableLogging)"
                )
            }
        }
    }
}

// MARK: - Reusable Components

struct DemoSection<Content: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Inter-Bold", size: 20))
                .foregroundColor(Asset.Colors.textPrimary.swiftUIColor)

            Text(description)
                .font(.custom("Inter-Regular", size: 14))
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)

            content
        }
        .padding(16)
        .background(Asset.Colors.surfaceColor.swiftUIColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Asset.Colors.textDisabled.swiftUIColor.opacity(0.2), lineWidth: 1)
        )
    }
}

struct ExampleCard: View {
    let title: String
    let code: String
    let result: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.custom("Inter-SemiBold", size: 12))
                .foregroundColor(Asset.Colors.textPrimary.swiftUIColor)

            Text(code)
                .font(.system(size: 11, design: .monospaced))
                .foregroundColor(Asset.Colors.infoColor.swiftUIColor)

            Text("→ \(result)")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(Asset.Colors.backgroundSecondary.swiftUIColor)
        .cornerRadius(8)
    }
}

struct ColorSwatch: View {
    let name: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Asset.Colors.textDisabled.swiftUIColor.opacity(0.3), lineWidth: 1)
                )

            Text(name)
                .font(.custom("Inter-Regular", size: 11))
                .foregroundColor(Asset.Colors.textSecondary.swiftUIColor)
        }
    }
}

// MARK: - Preview

struct SwiftGenDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftGenDemoView()
    }
}
