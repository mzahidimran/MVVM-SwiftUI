//
//  PaginatedResponse.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import Foundation

// MARK: - PaginatedResponse

/// Paginated response wrapper model
struct PaginatedResponse<T: Codable>: Codable {
    
    /// Total number of records
    var totalCount: Int = 0
    
    /// If record fetching was incomplete
    var incompleteResults: Bool = false
    
    /// Loaded records
    var items: [T] = []
    
    /// Helper if next page is available 
    var canLoadNextPage: Bool {
        if totalCount == 0 { return true }
        return totalCount > items.count
    }

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}
