//
//  UserSectionView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 03/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI

struct UserSectionView: View {
    
    // MARK:- Variables
    let strButton   : String
    let clrButton   : Color
    let strTitle1   : String
    let strImg1     : String
    let strCount1   : Int
    let strTitle2   : String
    let strImg2     : String
    let strCount2   : Int
    
    var onProfileButton1Pressed: (()->())?
    var onProfileButton2Pressed: (()->())?
    
    // MARK:- Main Body
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    VStack {
                        HStack {
                            Image(self.strImg1)
                            Text(self.strTitle1)
                        }
                        Button(action: {
                            self.onProfileButton1Pressed?()
                        }) {
                            Text("\(self.strCount1)")
                        }.multilineTextAlignment(.center)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(self.strImg2)
                            Text(self.strTitle2)
                        }
                        Button(action: {
                            self.onProfileButton2Pressed?()
                        }) {
                            Text("\(self.strCount2)")
                        }.multilineTextAlignment(.center)
                    }
                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            }
        }
    }
    
}

struct UserSectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserSectionView(strButton: "GitHub Profile", clrButton: Color.purple,strTitle1: "Public Repos", strImg1: "gh_Folder", strCount1: 46, strTitle2: "Public Gists", strImg2: "gh_Folder", strCount2: 2)
    }
}
