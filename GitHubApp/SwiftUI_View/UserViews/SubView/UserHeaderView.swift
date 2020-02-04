//
//  UserHeaderView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 03/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct UserHeaderView: View {
    // MARK:- Variables
    var objProfile: ProfileModel? = nil
    
    // MARK:- Main Body
    var body: some View {
        HStack(alignment: .top) {
            KFImage(URL(string: objProfile?.avatarURL ?? "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true")!)
            .resizable()
            .frame(width: 90, height: 90)
            .cornerRadius(8)
            .clipped()
            
            VStack(alignment: .leading) {
                Text(objProfile?.login ?? " NA ")
                    .font(.headline)
                Text(objProfile?.name ?? " NA ")
                    .lineLimit(2)
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct UserHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        UserHeaderView()
    }
}
