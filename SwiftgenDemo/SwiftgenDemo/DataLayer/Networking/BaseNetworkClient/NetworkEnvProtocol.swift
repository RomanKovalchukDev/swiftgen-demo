//
//  NetworkEnvProtocol.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation

protocol NetworkEnvProtocol {
    var baseUrl: URL { get }
    var ipCheckBaseURL: URL { get }
    var baseHeaders: NetworkingHeades { get }
    var onGetAuthHeader: NetworkingAuthProviderAction? { get }
}
