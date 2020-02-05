//
//  RepoListView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 05/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI

struct RepoListView: View {
    
    init(strPath: String) {
        self.strPath = strPath
        objRepo = RepoListModelClass(strSearch: strPath)
    }
    
    let strPath: String
    @ObservedObject var objRepo = RepoListModelClass(strSearch: "")
    
    private var stateContent: AnyView {
        switch objRepo.state {
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
                        ForEach(objRepo.gitRepos) { (item) in
                            RepoDetailsView(gitRepo: item)
                        }
                    }
                )
            }
        }
    }
    
    var body: some View {
        stateContent
    }
}


struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        RepoListView(strPath: "https://api.github.com/users/ShashikantBhadke/repos")
    }
}
