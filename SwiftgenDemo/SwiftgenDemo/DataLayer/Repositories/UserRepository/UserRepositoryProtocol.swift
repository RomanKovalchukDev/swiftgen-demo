//
//  UserRepositoryProtocol.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Combine
import Foundation

protocol UserRepositoryProtocol {
    var accessToken: String? { get }
    var isSignedIn: Bool { get }
    
    var accessTokenChangedPublisher: AnyPublisher<String?, Never> { get }
    var signInStateChangedPublisher: AnyPublisher<Bool, Never> { get }
    
    func singIn() async throws
}
