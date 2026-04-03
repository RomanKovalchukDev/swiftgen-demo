//
//  View+If.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<TrueContent: View>(
        _ condition: Bool,
        then trueContent: (Self) -> TrueContent
    ) -> some View {
        if condition {
            trueContent(self)
        }
        else {
            self
        }
    }

    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        then trueContent: (Self) -> TrueContent,
        else falseContent: (Self) -> FalseContent
    ) -> some View {
        if condition {
            trueContent(self)
        }
        else {
            falseContent(self)
        }
    }
}
