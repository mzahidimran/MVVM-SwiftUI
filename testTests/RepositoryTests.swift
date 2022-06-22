//
//  testTests.swift
//  testTests
//
//  Created by Muhammad Zahid Imran on 23/03/2022.
//

import XCTest
@testable import test
import Combine

class RepositoryTests: XCTestCase {

    var repository: RemoteRepository?
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        self.cancellables = []
        self.repository = RemoteRepository(testMode: true)
    }
    
    override func tearDown() {
        super.tearDown()
        repository = nil
        cancellables = []
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        repository = nil
        cancellables = []
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoading() throws {
        
        var response: PaginatedResponse<User> = PaginatedResponse<User>()
        var error: Error?
        let expectation = self.expectation(description: "searchUsers")
        
        repository?.searchUsers(query: "", perPage: 20, page: 1)
            .sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let encounteredError):
                    error = encounteredError
                }
                expectation.fulfill()
            } receiveValue: { result in
                response = result
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)
        XCTAssertNil(error)
        XCTAssert(response.items.count == 2)
        XCTAssert(response.totalCount == 4)
        XCTAssert(response.canLoadNextPage)
    }

}
