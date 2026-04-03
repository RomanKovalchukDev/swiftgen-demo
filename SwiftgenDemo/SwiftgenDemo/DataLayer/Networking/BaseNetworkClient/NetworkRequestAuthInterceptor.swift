//
//  NetworkRequestAuthInterceptor.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Alamofire
import Foundation
import NerdzInject

// Due to sendable nature of this class, we will pass dependency
final class NetworkRequestAuthInterceptor: NetworkRequestAuthInterceptorProtocol, @unchecked Sendable {

    @ForceInject private var userRepository: UserRepositoryProtocol

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        guard let authHeader = userRepository.accessToken else {
            completion(.success(urlRequest))
            return
        }
        
        var newUrlRequest = urlRequest
        
        newUrlRequest.setValue(
            authHeader,
            forHTTPHeaderField: NetworkRequestHeaderKey.authorization.rawValue
        )
        
        completion(.success(newUrlRequest))
    }
}
