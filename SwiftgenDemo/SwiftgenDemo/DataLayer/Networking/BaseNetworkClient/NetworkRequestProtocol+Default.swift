//
//  NetworkRequestProtocol+Default.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Alamofire
import Foundation

/// Default implementation of `BaseNetworkRouterType` protocol
extension NetworkRequestProtocol where Self: URLRequestConvertible {
    
    var queryParameters: NetworkingQueryParameters? {
        [:]
    }
    
    var bodyParameters: NetworkingBodyParameters? {
        [:]
    }
    
    var body: Encodable? {
        nil
    }
    
    var headers: NetworkingHeades? {
        [:]
    }
    
    func addQueryParameters(to urlRequest: URLRequest) throws -> URLRequest {
        try URLEncodedFormParameterEncoder(destination: .queryString).encode(queryParameters, into: urlRequest)
    }
    
    func addHeaders(to request: URLRequest) -> URLRequest {
        var newRequest = request
        
        for (key, value) in headers ?? [:] {
            newRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return newRequest
    }
    
    func addBodyParameters(to request: URLRequest) throws -> URLRequest {
        let jsonEncoder = JSONEncoder()
        
        var newRequest = request
        
        if let body = self.body {
            newRequest.httpBody = try jsonEncoder.encode(body)
        }
        else if let bodyParameters = self.bodyParameters, !bodyParameters.isEmpty {
            newRequest = try JSONEncoding.default.encode(request, with: bodyParameters)
        }
        
        return newRequest
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = try URLRequest(url: url, method: method)
        
        request = addHeaders(to: request)
        request = try addQueryParameters(to: request)
        request = try addBodyParameters(to: request)
        
        return request
    }
}
