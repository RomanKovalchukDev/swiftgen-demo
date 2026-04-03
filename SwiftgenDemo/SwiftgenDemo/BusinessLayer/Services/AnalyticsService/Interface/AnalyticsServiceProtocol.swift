//
//  AnalyticsServiceProtocol.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation

protocol AnalyticsServiceProtocol {
    init(analyticsProviders: [AnalyticsProviderProtocol])
    
    func logEvent(_ event: AnalyticsEventType)
}
