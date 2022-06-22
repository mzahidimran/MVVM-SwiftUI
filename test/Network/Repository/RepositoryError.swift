//
//  RepositoryError.swift
//  test
//
//  Created by Muhammad Zahid Imran on 25/03/2022.
//

import Foundation

/// Basic error types are defined we can add more details to it
enum RepositoryErrorType {
    case invalidRequest
    case invalidResponse
    case unAuthorized
    case notFound
    case unknown
}

/// Protocol wraps the error for repository
protocol RepositoryErrorProtocol {
    var type: RepositoryErrorType { get }
    var statusCode: Int { get }
    var errorDescription: String { get }
    var rawData: Data? { get }
}


/// RepositoryError is the error may occur reading data from repository.
///

struct RepositoryError: Swift.Error, RepositoryErrorProtocol {
    
    /// Basic error types may occur while communicating with Repository
    var type: RepositoryErrorType {
        switch statusCode {
        case 404:
            return .notFound
        case 400:
            return .invalidRequest
        case 401, 403:
            return .unAuthorized
        default:
            return .unknown
        }
    }
    
    /// Status code is error code from repository which can be Network codes OR custom codes
    var statusCode: Int
    
    /// Error description message.
    var errorDescription: String
    
    /// Optional raw data for mics data with error
    var rawData: Data?
}
