//
//  EndPoint.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import Foundation
import Moya


/// Sort for endpoints records
enum Sort: String {
    /// `Sort` sort the records `asc` and `desc`
    case desc, asc
}


// MARK: - Enpoints for repository
enum Endpoint {
    /// *case* Search User
    /// - Parameter q: Query to load the users login
    /// - Parameter perPage: Number of records per page
    /// - Parameter page: Page number to load
    /// - Parameter sort: `Sort` sort the records `asc` and `desc`
    case searchUser(q: String, perPage: Int, page: Int, sort: Sort = .desc)
}

// MARK: - TargetType Protocol Implementation
/// Read Moya docs for details  https://github.com/Moya/Moya/blob/master/docs/Examples/Basic.md
extension Endpoint: TargetType {
    
    var baseURL: URL { URL(string: "https://api.github.com")! }
    var path: String {
        switch self {
        case .searchUser:
            return "search/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchUser:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .searchUser(let q, let perPage, let page, let sort):
            return .requestParameters(parameters: ["q": "\(q) in:login", "per_page": perPage, "page": page, "order": sort.rawValue], encoding: URLEncoding.queryString)
        }
    }
    
    var validationType: ValidationType {
            switch self {
            case .searchUser:
                return .successCodes
            }
        }
    
    var sampleData: Data {
        switch self {
        case .searchUser:
            return """
                {
                  "total_count": 4,
                  "incomplete_results": false,
                  "items": [
                    {
                      "login": "zahid",
                      "id": 626423,
                      "node_id": "MDQ6VXNlcjYyNjQyMw==",
                      "avatar_url": "https://avatars.githubusercontent.com/u/626423?v=4",
                      "gravatar_id": "",
                      "url": "https://api.github.com/users/zahid",
                      "html_url": "https://github.com/zahid",
                      "followers_url": "https://api.github.com/users/zahid/followers",
                      "following_url": "https://api.github.com/users/zahid/following{/other_user}",
                      "gists_url": "https://api.github.com/users/zahid/gists{/gist_id}",
                      "starred_url": "https://api.github.com/users/zahid/starred{/owner}{/repo}",
                      "subscriptions_url": "https://api.github.com/users/zahid/subscriptions",
                      "organizations_url": "https://api.github.com/users/zahid/orgs",
                      "repos_url": "https://api.github.com/users/zahid/repos",
                      "events_url": "https://api.github.com/users/zahid/events{/privacy}",
                      "received_events_url": "https://api.github.com/users/zahid/received_events",
                      "type": "User",
                      "site_admin": false,
                      "score": 1.0
                    },
                    {
                      "login": "zahidkizmaz",
                      "id": 15658403,
                      "node_id": "MDQ6VXNlcjE1NjU4NDAz",
                      "avatar_url": "https://avatars.githubusercontent.com/u/15658403?v=4",
                      "gravatar_id": "",
                      "url": "https://api.github.com/users/zahidkizmaz",
                      "html_url": "https://github.com/zahidkizmaz",
                      "followers_url": "https://api.github.com/users/zahidkizmaz/followers",
                      "following_url": "https://api.github.com/users/zahidkizmaz/following{/other_user}",
                      "gists_url": "https://api.github.com/users/zahidkizmaz/gists{/gist_id}",
                      "starred_url": "https://api.github.com/users/zahidkizmaz/starred{/owner}{/repo}",
                      "subscriptions_url": "https://api.github.com/users/zahidkizmaz/subscriptions",
                      "organizations_url": "https://api.github.com/users/zahidkizmaz/orgs",
                      "repos_url": "https://api.github.com/users/zahidkizmaz/repos",
                      "events_url": "https://api.github.com/users/zahidkizmaz/events{/privacy}",
                      "received_events_url": "https://api.github.com/users/zahidkizmaz/received_events",
                      "type": "User",
                      "site_admin": false,
                      "score": 1.0
                    }
                  ]
                }
                """.utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
