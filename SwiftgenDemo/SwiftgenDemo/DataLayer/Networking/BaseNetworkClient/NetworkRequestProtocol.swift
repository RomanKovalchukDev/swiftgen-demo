//
//  NetworkRequestProtocol.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Foundation
import Alamofire

/// A protocol for defining the properties of a network router.
protocol NetworkRequestProtocol: URLRequestConvertible {
    /// The base URL for the router.
    var baseURL: URL { get }
    
    /// The path for the router.
    var path: String { get }
    
    /// The HTTP method for the router.
    var method: HTTPMethod { get }
    
    /// The headers for the router.
    var headers: NetworkingHeades? { get }
    
    /// The query parameters for the router.
    var queryParameters: NetworkingQueryParameters? { get }
    
    /// The body parameters for the router.
    var bodyParameters: NetworkingBodyParameters? { get }
    
    /// The body data for the router, if any.
    var body: Encodable? { get }
    
    /// Adds query parameters to a given URL request.
    /// - Parameter urlRequest: The URL request to add query parameters to.
    func addQueryParameters(to urlRequest: URLRequest) throws -> URLRequest
    
    /// Adds headers to a given URL request.
    /// - Parameter request: The URL request to add headers to.
    func addHeaders(to request: URLRequest) -> URLRequest
    
    /// Adds body parameters to a given URL request.
    /// - Parameter request: The URL request to add body parameters to.
    func addBodyParameters(to request: URLRequest) throws -> URLRequest
}
