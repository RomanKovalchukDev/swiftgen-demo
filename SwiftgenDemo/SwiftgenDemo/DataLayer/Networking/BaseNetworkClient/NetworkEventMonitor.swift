//
//  NetworkEventMonitor.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import Alamofire
import Foundation
import NerdzInject
import NerdLogger

/// A custom EventMonitor that logs network requests and their response data.
final class NetworkEventMonitor: EventMonitor, @unchecked Sendable {

    /// A serial queue used to perform all logging operations.
    let queue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier ?? "").NetworkEventMonitor")

    @ForceInject private var loggerSystem: LogProtocol

    init() {}

    /// Called when a `Request` has finished.
    /// - Parameter request: The finished `Request`.
    func requestDidFinish(_ request: Request) {
        loggerSystem.info("Request did finish: \(request.description)")
    }

    /// Called after a response has been serialized.
    /// - Parameters:
    /// - request: The `DataRequest` that performed the response serialization.
    /// - response: The `DataResponse` containing the serialized result.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            loggerSystem.debug("Response JSON: \(json)")
        }
    }
}
