//
//  DataRequest+ValidateWithErrorResponse.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Alamofire
import Foundation

extension DataRequest {
    func validateWithErrorResponse() -> DataRequest {
        self.validate { _, response, data in
            guard !(200..<300).contains(response.statusCode) else {
                return .success(())
            }
            
            if let data, let apiError = try? JSONDecoder.apiDecoder.decode(CommonErrorResponse.self, from: data) {
                return .failure(CommonError.networkError(apiError.message))
            }
            
            return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode)))
        }
    }
}
