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
    
    var onProfileButtonPressed: (()->())?
    
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
                        Text("\(self.strCount1)")
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(self.strImg2)
                            Text(self.strTitle2)
                        }
                        Text("\(self.strCount2)")
                    }
                }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                Button(action: {
                    self.onProfileButtonPressed?()
                }) {
                    Text(self.strButton)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                        
                }.frame(width: geometry.size.width - 40, height: 50)
                    .background(self.clrButton)
                .cornerRadius(8)
            }
        }
    }
    
}

struct UserSectionView_Previews: PreviewProvider {
    static var previews: some View {
        UserSectionView(strButton: "GitHub Profile", clrButton: Color.purple,strTitle1: "Public Repos", strImg1: "gh_Folder", strCount1: 46, strTitle2: "Public Gists", strImg2: "gh_Folder", strCount2: 2)
    }
}
