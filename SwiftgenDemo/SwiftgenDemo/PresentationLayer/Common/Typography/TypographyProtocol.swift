//
//  TypographyProtocol.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

protocol TypographyProtocol {
    var font: SwiftUI.Font { get }
    
    #if os(iOS) || os(tvOS) || os(watchOS)
    var uikitFont: UIFont { get }
    #elseif os(macOS)
    var nsFont: NSFont { get }
    #endif
    
    var fontHeight: CGFloat { get }
    var lineHeight: CGFloat { get }
    var lineSpacing: CGFloat { get }
    var letterSpacing: CGFloat { get }
}
