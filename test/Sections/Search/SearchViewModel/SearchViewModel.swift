//
//  SearchViewModel.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import Foundation
import Combine


/// Search ViewModel implements logic for user search view
class SearchViewModel: ObservableObject {
    
    /// current loaded content `PaginatedResponse`
    @Published var response: PaginatedResponse<User> = PaginatedResponse<User>()
    
    /// view state
    @Published var state: ViewState = .idle
    
    /// clears the view model when query is updated.
    @Published var searchQuery: String = "" {
        didSet {
            clear()
        }
    }
    let repository: Repository
    
    /// token contains cancelable for current request which can be cancelled anytime manually
    private var requestPipelineToken: AnyCancellable?
    
    /// Number of records per page
    private let pageSize = 20
    
    /// current loaded page `Default` : 0 means no page loaded.
    private var page = 0
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    
    /// Reset the view model states
    private func clear() {
        self.response = PaginatedResponse<User>()
        self.page = 0
    }

    
    /// Refresh the new search query
    func refresh() {
        clear()
        requestPipelineToken?.cancel()
        self.state = .loading
        requestPipelineToken = repository.searchUsers(query: searchQuery, perPage: 9, page: 1, sort: .asc)
            .sink {[unowned self] (state) in
                switch (state) {
                case .finished:
                    self.state = .idle
                case .failure(let error):
                    self.state = .error(error: error.localizedDescription)
                }
            } receiveValue: {[unowned self] (response) in
                self.page = 1
                self.response = response
            }
    }

    
    /// Load next page if possible.
    func loadNextPageIfPossible() {
        guard response.canLoadNextPage else { return }
        requestPipelineToken?.cancel()
        self.state = .loading
        requestPipelineToken = repository.searchUsers(query: searchQuery, perPage: 9, page: page + 1, sort: .asc)
            .sink {[unowned self] (state) in
                switch (state) {
                case .finished:
                    self.state = .idle
                case .failure(let error):
                    self.state = .error(error: error.localizedDescription)
                }
            } receiveValue: {[unowned self] (response) in
                self.page += 1
                if page == 1 {
                    self.response = response
                } else {
                    self.response.items += response.items
                    self.response.totalCount = response.totalCount
                    self.response.incompleteResults = response.incompleteResults
                }
            }
    }
}
