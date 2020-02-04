//
//  UsersView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 03/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI

struct UsersView: View {
    
    init(strName: String) {
        self.strName = strName
        objProfile = ProfileModelClass(strSearch: strName)
    }
    
    let strName: String
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var objProfile = ProfileModelClass(strSearch: "")
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    UserHeaderView(objProfile: self.objProfile.profileObj)
                    Text(self.objProfile.profileObj?.bio ?? " NA ")
                        .lineLimit(3)
                    UserSectionView(strButton:"GitHub Profile", clrButton: Color.purple, strTitle1: "Public Repos", strImg1: "gh_Folder", strCount1: self.objProfile.profileObj?.publicRepos ?? 0, strTitle2: "Public Gists", strImg2: "gh_Folder", strCount2: self.objProfile.profileObj?.publicGists ?? 0) {
                        
                    }
                    .frame(width: geometry.size.width - 40, height: 140)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                    
                    UserSectionView(strButton:"Get Follower", clrButton: Color.green, strTitle1: "Following", strImg1: "gh_Heart", strCount1: self.objProfile.profileObj?.following ?? 0, strTitle2: "Followers", strImg2: "gh_People", strCount2: self.objProfile.profileObj?.followers ?? 0) {
                        
                    }
                    .frame(width: geometry.size.width - 40, height: 140)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(5)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(strName: "_Test_")
    }
}


