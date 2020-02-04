//
//  UserListView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 03/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct UserListView: View {
    
    init(searchName: String, pushed: Binding<Bool>) {
        self.searchName = searchName
        self.objGitHub = GitHubModel(strSearch: searchName)
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
    }
    
    var searchName = ""
    @State var pushToHome = false    
    @ObservedObject var objGitHub = GitHubModel(strSearch: "")
    @Environment(\.presentationMode) var presentationMode
    /**
     ForEach(0..<(Int(objGitHub.gitHubUser.count / 3))) { index in
         HStack(spacing: 20) {
             ForEach(0..<self.getUserView(index).count) { index1 in
                 self.getUserView(index)[index1].sheet(isPresented: self.$pushToHome) {
                     UsersView(strName: "\(index1)")
                 }.onTapGesture {
                     self.pushToHome.toggle()
                 }
             }
         }
     }     
     */
    
    var body: some View {
        //ScrollView(showsIndicators: false) {
            List {
                ForEach(objGitHub.gitHubUser) { (item) in
                    NavigationLink(destination: UsersView(strName: item.login ?? self.searchName)) {
                        UserProfileView(intID: item.id, gitUser: item)
                    }
                }
            }
        .navigationBarTitle(Text(self.searchName), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("gh_BackArrow")
            }))
    }
    
    func getUserView(_ index: Int)->[GitHubUsers] {
        var arr = [GitHubUsers]()
        let index0 = index * 3
        if self.objGitHub.gitHubUser.count > index0 {
            arr.append(self.objGitHub.gitHubUser[index0])
        }
        let index1 = index0 + 1
        if self.objGitHub.gitHubUser.count > index1 {
            arr.append(self.objGitHub.gitHubUser[index1])
        }
        let index2 = index0 + 2
        if self.objGitHub.gitHubUser.count > index2 {
            arr.append(self.objGitHub.gitHubUser[index2])
        }
        return arr
    }
}


//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView(pushed: false)
//    }
//}
