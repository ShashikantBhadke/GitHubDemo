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
    }
    
    var searchName = ""
    @State var pushToHome = false
    @ObservedObject var objGitHub = GitHubModel(strSearch: "")
    @Environment(\.presentationMode) var presentationMode
    
    private var stateContent: AnyView {
        switch objGitHub.state {
        case .loading:
            return AnyView(
                ActivityIndicator(style: .medium)
            )
        case .fetched(let result):
            switch result {
            case .failure(let error):
                return AnyView(
                    Text(error)
                )
            case .success( _):
                return AnyView(
                    List {
                        ForEach(objGitHub.gitHubUser) { (item) in
                            UserProfileView(intID: item.id, gitUser: item)
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
                )
            }
        }
    }
    
    var body: some View {
        stateContent
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
