//
//  Util.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import SwiftUI

/// ViewState represent the state of async loadable objects
enum ViewState: Equatable {
    
    /// Loading state
    case loading
    
    /// Error while loading
    case error(error: String)
    
    /// Loaded or before loading state.
    case idle

    /// Helper isLoading 
    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}

