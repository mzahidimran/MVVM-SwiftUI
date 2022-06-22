//
//  User.swift
//  test
//
//  Created by Muhammad Zahid Imran on 24/03/2022.
//

import Foundation
import SwiftUI

// MARK: - User

/// User model 
struct User: Codable {
    
    enum UserType: String, Codable {
        case user = "User"
        case organization = "Organization"
    }
    let id: String = UUID().uuidString
    let login: String?
    let userID: Int
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url: String?
    let htmlURL: String?
    let followersURL: String?
    let followingURL: String?
    let gistsURL: String?
    let starredURL: String?
    let subscriptionsURL: String?
    let organizationsURL: String?
    let reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let siteAdmin: Bool?
    let score: Int?
    let type: UserType?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case userID = "id"
        case type = "type"
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url = "url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case siteAdmin = "site_admin"
        case score = "score"
    }
}

extension User: Identifiable { }

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
