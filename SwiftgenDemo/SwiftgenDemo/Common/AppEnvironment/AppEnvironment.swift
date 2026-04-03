//
//  AppEnvironment.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation

struct AppEnvironment {
    
    // MARK: - Properties(static)
    
    static let production = AppEnvironment(
        apiBaseURLString: "https://jsonplaceholder.typicode.com"
    )
    
    static let dev = AppEnvironment(
        apiBaseURLString: "https://jsonplaceholder.typicode.com"
    )

    static var current: AppEnvironment {
        #if DEV_ENV
        return .dev
        #else
        return .production
        #endif
    }
    
    // MARK: - Properties(public)
    
    var apiBaseURL: URL {
        guard let url = URL(string: apiBaseURLString) else {
            fatalError("Base url not setup")
        }
        
        return url
    }
    
    // MARK: - Properties(private)
    
    private let apiBaseURLString: String
}
