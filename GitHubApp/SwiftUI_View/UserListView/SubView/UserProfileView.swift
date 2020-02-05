//
//  UserProfileView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 03/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct UserProfileView: View {
    
    let intID: Int
    var gitUser: GitHubUsers
    @State var isShowProfileDetails = false
    
    var body: some View {
        HStack() {
            KFImage(URL(string: gitUser.avatarURL ?? "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true")!)
                .resizable()
                .frame(width: 90, height: 90)
                .cornerRadius(8)
                .clipped()
            VStack(alignment: .leading) {
                Text("ID:- \(self.gitUser.id)")
                    .font(.headline)
                    .lineLimit(1)
                Text(self.gitUser.login ?? "")
                    .font(.subheadline)
                    .lineLimit(3)
            }
            Spacer()
            Button(action: {
                self.isShowProfileDetails = true
            }) {
                Image("gh_Info")
                .resizable()
                .fixedSize()
                .clipped()
            }
        }.sheet(isPresented: self.$isShowProfileDetails) {
            UsersView(strName: self.gitUser.login ?? "")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(intID: 1, gitUser: GitHubUsers(login: "tes", id: 0, nodeID: "", avatarURL: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: "", siteAdmin: false, score: 3))
    }
}
