//
//  AnalyticsService.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation

/// App analytics service implementation
final class AnalyticsService: NSObject, AnalyticsServiceProtocol {
    
    // MARK: - Properties(private)
    
    private let providers: [any AnalyticsProviderProtocol]
    
    // MARK: - Life cycle
    
    /// Initializes an instance of an analytics service with the given parameters.
    /// - Parameter analyticsProviders: An array of objects that conform to the `AnalyticsProviderProtocol` protocol.
    init(analyticsProviders: [AnalyticsProviderProtocol]) {
        self.providers = analyticsProviders
        
        super.init()
        
        subscribeToListeners()
    }
    
    // MARK: - Methods(public)
    
    /// Logs an event to all the analytics providers.
    /// - Parameter event: An `AnalyticsEventType` that defines the event to log.
    func logEvent(_ event: AnalyticsEventType) {
        providers.forEach { provider in
            provider.trackEvent(event)
        }
    }
    
    // MARK: - Methods(private)
    
    /// Method that listens to user events
    private func subscribeToListeners() {
    }
}
