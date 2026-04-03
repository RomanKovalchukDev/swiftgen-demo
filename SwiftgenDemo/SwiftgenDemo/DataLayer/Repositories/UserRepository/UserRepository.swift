//
//  UserRepository.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Combine
import Foundation
import NerdzInject
import Alamofire

final class UserRepository: UserRepositoryProtocol {
    
    // MARK: - Properties(public)
    
    var accessToken: String?
    var isSignedIn: Bool = false
    
    var accessTokenChangedPublisher: AnyPublisher<String?, Never> {
        accessTokenSubject.eraseToAnyPublisher()
    }
    
    var signInStateChangedPublisher: AnyPublisher<Bool, Never> {
        signInStateSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Properties(private)
    
    private let accessTokenSubject = PassthroughSubject<String?, Never>()
    private let signInStateSubject = PassthroughSubject<Bool, Never>()
    
    // MARK: - Dependencies
    
    @ForceInject private var networkSession: Session
    
    // MARK: - Methods(public)
    
    func singIn() async throws {
        let requestInterface = SignInRequest()
        
        let dataRequest = networkSession.request(requestInterface)
            .validateWithErrorResponse()
            .serializingDecodable(AuthResponse.self, decoder: JSONDecoder.apiDecoder)
        
        let value = try await dataRequest.value
        accessToken = value.token
    }
}
