//
//  TextStyleModifier.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct TextStyleModifier: ViewModifier {
    let foregroundColor: Color
    let typographyStyle: TypographyProtocol

    func body(content: Content) -> some View {
        content
            .foregroundStyle(foregroundColor)
            .font(typographyStyle.font)
            .lineSpacing(typographyStyle.lineSpacing)
    }
}
