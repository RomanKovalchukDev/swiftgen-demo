//
//  View+Redacted.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

extension View {
    func redacted(if condition: Bool, disable: Bool = true) -> some View {
        redacted(reason: condition ? .placeholder : [])
            .disabled(disable ? condition : false)
    }
}
