//
//  ProfileModel.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 04/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

public enum Result<T, String> {
    case success(T)
    case failure(String)
}

enum LoadableState<T> {
    case loading
    case fetched(Result<T, String>)
}

final class ProfileModelClass: ObservableObject {

    required init(strSearch: String) {
        self.strSearch = strSearch
        if !strSearch.isEmpty {
            userWhose()
        } else {
            state = .fetched(.failure("Enter name"))
        }
    }
    
    var strSearch = ""
    var state: LoadableState<ProfileModel> = .loading    
    @Published var profileObj: ProfileModel? = nil

    // MARK:- WebService
    func userWhose() {
        WebService.call(withAPIType: .GET, withAPI: .usersName, strID: self.strSearch, withParameters: [:], withDecodabel: ProfileModel.self) { (result) in
            switch result {
            case .Success(let obj, _):
                self.state = .fetched(.success(obj))
                self.profileObj = obj
            case .Error(let err):
                self.state = .fetched(.failure(err))
                self.profileObj = nil
            }
        }
    }
}

// MARK: - ProfileModel
struct ProfileModel: Codable, Identifiable {
    
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
    var name: String?
    var blog: String?
    var email: String?
    var hireable: Bool?
    var bio: String?
    var publicRepos, publicGists, followers, following: Int?

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
        case name, blog, email, hireable, bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
    }
}
