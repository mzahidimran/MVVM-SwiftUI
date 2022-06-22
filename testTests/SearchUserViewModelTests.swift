//
//  SearchUserViewModelTests.swift
//  testTests
//
//  Created by Muhammad Zahid Imran on 25/03/2022.
//

import XCTest
@testable import test
import Combine

class SearchUserViewModelTests: XCTestCase {

    private var repository: RemoteRepository!
    private var viewModel: SearchViewModel!
    private var cancellables: [AnyCancellable]!
    
    override func setUp() {
        super.setUp()
        self.cancellables = []
        self.repository = RemoteRepository(testMode: true)
        self.viewModel = SearchViewModel(repository: repository)
    }
    
    override func tearDown() {
        super.tearDown()
        cancellables = []
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        cancellables = []
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoading() throws {
        let expectation = self.expectation(description: "searchUsers")
        viewModel!.$state.dropFirst().sink(receiveValue: { state in
            if state == .idle {
                expectation.fulfill()
            }
        })
            .store(in: &cancellables)
        
        viewModel?.refresh()
        waitForExpectations(timeout: 10)
        
        XCTAssert(viewModel.response.items.count == 2)
        XCTAssert(viewModel.response.totalCount == 4)
        XCTAssert(viewModel.response.canLoadNextPage)
        for item in cancellables {
            item.cancel()
        }
    }
    
    func testLoadNextIfPossible() throws {
        let expectation = self.expectation(description: "searchUsers")
        viewModel!.$state.dropFirst().sink(receiveValue: { state in
            if state == .idle {
                expectation.fulfill()
            }
        })
            .store(in: &cancellables)
        
        XCTAssert(viewModel.response.canLoadNextPage)
        
        viewModel?.loadNextPageIfPossible()
        waitForExpectations(timeout: 10)
        
        XCTAssert(viewModel.response.items.count == 2)
        XCTAssert(viewModel.response.totalCount == 4)
        XCTAssert(viewModel.response.canLoadNextPage)
        for item in cancellables {
            item.cancel()
        }
    }
    
    func testClear() {
        viewModel.searchQuery = "r"
        XCTAssert(viewModel.response.items.count == 0)
        XCTAssert(viewModel.response.totalCount == 0)
        XCTAssertTrue(viewModel.response.canLoadNextPage)
    }

}
