//
//  Repository.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import Foundation
import Combine


/// Repository interface for data
protocol Repository {
    
    /// *func* Search User 
    /// - Parameter query: Query to load the users login
    /// - Parameter perPage: Number of records per page
    /// - Parameter page: Page number to load
    /// - Parameter sort: `Sort` sort the records `asc` and `desc`
    /// - Returns: `PaginatedResponse<User>`
    func searchUsers(query: String, perPage: Int, page: Int, sort: Sort) -> AnyPublisher<PaginatedResponse<User>, RepositoryError>
}

