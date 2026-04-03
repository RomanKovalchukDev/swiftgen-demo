//
//  GoogleAnalyticsProvider.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation
import Firebase
import FirebaseAnalytics

/// A class that conforms to AnalyticsProviderProtocol protocol and provides Google Analytics implementation for tracking user analytics events.
final class GoogleAnalyticsProvider: AnalyticsProviderProtocol {
    
    /// Sends an analytics event to Google Analytics.
    /// - Parameter event: An `AnalyticsEventType` that represents the event to be tracked.
    func trackEvent(_ event: AnalyticsEventType) {
        Analytics.logEvent(event.key, parameters: event.parameters)
    }
    
    /// Clears user identification from Google Analytics.
    func clearUser() {
        Analytics.setUserID(nil)
    }
    
    /// Updates user identification with new user id and user data in Google Analytics.
    func updateUser(with id: String, userData: [String: Any]) {
        Analytics.setUserID(id)
        
        for (key, value) in userData {
            guard let mappedValue = value as? String else {
                return
            }
            
            Analytics.setUserProperty(mappedValue, forName: key)
        }
    }
}
