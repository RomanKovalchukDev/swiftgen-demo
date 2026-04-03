//
//  SignInRequest.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Alamofire
import Foundation

struct SignInRequest: NetworkRequestProtocol {
    
    var baseURL: URL {
        AppEnvironment.current.apiBaseURL
    }
    
    var path: String {
        ""
    }
    
    var method: Alamofire.HTTPMethod {
        .get
    }
}
