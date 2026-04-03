//
//  AnalyticsProviderProtocol.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation

protocol AnalyticsProviderProtocol: AnyObject {
    
    /// Track an event with the given event type.
    /// - Parameter event: The event to track.
    func trackEvent(_ event: AnalyticsEventType)
    
    /// Clear user data that is being tracked by the analytics provider.
    func clearUser()
    
    /// Update user data being tracked by the analytics provider with the given ID and user data.
    /// - Parameters:
    ///   - id: The ID of the user.
    ///   - userData: The user data to update.
    func updateUser(with id: String, userData: [String: Any])
}
