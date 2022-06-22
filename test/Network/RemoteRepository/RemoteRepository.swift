//
//  Repository.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import Foundation
import Combine
import Moya
import CombineMoya

var isUITestMode: Bool {
    let isUITestMode = ProcessInfo.processInfo.arguments.contains("UITEST_MODE")
    return isUITestMode
}

// MARK: - Remote Repository Implementation
class RemoteRepository {
    
    private let provider: MoyaProvider<Endpoint>
    
    init(testMode: Bool = isUITestMode) {
        if testMode {
            provider = MoyaProvider<Endpoint>(stubClosure: MoyaProvider<Endpoint>.immediatelyStub(_:))
        } else {
            provider = MoyaProvider<Endpoint>()
        }
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, RepositoryError> {
        let decoder = JSONDecoder()
        return provider.requestPublisher(endpoint, callbackQueue: DispatchQueue.main)
            .tryMap { response -> T in
                try response.map(T.self, using: decoder, failsOnEmptyData: false)
            }
            .mapError { afError -> RepositoryError in
                let error = afError as! MoyaError
                return RepositoryError(statusCode: error.errorCode, errorDescription: error.localizedDescription, rawData: error.response?.data)
            }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Repository Protocol Implementation
extension RemoteRepository: Repository {
    
    func searchUsers(query: String, perPage: Int, page: Int, sort: Sort = .desc) -> AnyPublisher<PaginatedResponse<User>, RepositoryError> {
        request(.searchUser(q: query, perPage: perPage, page: page, sort: sort))
    }
    
}

