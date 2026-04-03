//
//  View+WithAppStyle.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

extension View {
    func withAppStyle(color: Color, typography: TypographyProtocol) -> some View {
        self.modifier(TextStyleModifier(foregroundColor: color, typographyStyle: typography))
    }
}
