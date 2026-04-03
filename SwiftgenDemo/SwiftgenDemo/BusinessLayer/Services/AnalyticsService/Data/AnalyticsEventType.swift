//
//  AnalyticsEventType.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

enum AnalyticsEventType {
    case signUpButtonPressed
}

extension AnalyticsEventType {
    var key: String {
        switch self {
        case .signUpButtonPressed:
            return "sign_up_button_pressed"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .signUpButtonPressed:
            return [:]
        }
    }
}
