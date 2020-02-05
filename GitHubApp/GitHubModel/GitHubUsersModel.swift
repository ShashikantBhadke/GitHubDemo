//
//  GitHubUsersModel.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 04/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

final class GitHubModel: ObservableObject {

    required init(strSearch: String) {
        self.strSearch = strSearch
        if !strSearch.isEmpty {
            getData()
        } else {
            state = .fetched(.failure("Enter name"))
        }
    }
    
    var strSearch = ""
    var state: LoadableState<[GitHubUsers]> = .loading
    @Published var gitHubUser = [GitHubUsers]()

    // MARK:- WebService
    func getData() {
        GitHubUsersModel.searchUserBy(self.strSearch) { (result) in
            switch result {
            case .Success(let obj, _):
                self.gitHubUser = obj.items ?? []
                self.state = .fetched(.success(obj.items ?? []))
            case .Error(let err):
                self.gitHubUser = []
                self.state = .fetched(.failure(err))
            }
        }
    }
}


// MARK: - GithubUsersModel
struct GitHubUsersModel: Codable {
    var totalCount: Int?
    var incompleteResults: Bool?
    var items: [GitHubUsers]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    static func searchUserBy(_ strName: String, onComplection: @escaping((ResultAPI<GitHubUsersModel>)->())) {
        var param = [String: String]()
        param["q"] = strName
        WebService.call(withAPIType: .GET, withAPI: .searchUsers, withParameters: param, withDecodabel: GitHubUsersModel.self) { (result) in
            switch result {
            case .Success(let obj, let data):
                onComplection(.Success(obj, data))
            case .Error(let strErr):
                onComplection(.Error(strErr))
            }
        }
    }
}

// MARK: - Item
struct GitHubUsers: Codable, Identifiable {
    var login: String?
    var id: Int
    var nodeID: String?
    var avatarURL: String?
    var gravatarID: String?
    var url, htmlURL, followersURL: String?
    var followingURL, gistsURL, starredURL: String?
    var subscriptionsURL, organizationsURL, reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin: Bool?
    var score: Double?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
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
        case type
        case siteAdmin = "site_admin"
        case score
    }
}
