//
//  RepoDetailsView.swift
//  GitHubApp
//
//  Created by Shashikant's_Macmini on 05/02/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import SwiftUI

struct RepoDetailsView: View {
    
    // MARK:- Variables
    var gitRepo: RepoListModelElement
    
    // MARK:- View
    var body: some View {
        VStack(alignment: .leading) {
            Text(gitRepo.name ?? "")
                .font(.headline)
                .lineLimit(2)
            Text(gitRepo.repoListModelDescription ?? "")
                .font(.body)
                .lineLimit(3)
            HStack {
                Text("Language:")
                    .font(.body)
                Text(gitRepo.language ?? "")
                    .font(.headline)
                    .foregroundColor(Color.green)
            }
            HStack {
                Image("gh_Stars")
                    .frame(width: 20, height: 20)
                    .clipped()
                Text("\(gitRepo.stargazersCount ?? 0)")
                    .font(.headline)
                Image("gh_Fork")
                    .frame(width: 20, height: 20)
                    .clipped()
                Text("\(gitRepo.forksCount ?? 0)")
                    .font(.headline)
            }
            HStack {
                Image("gh_LastUpdate")
                    .frame(width: 20, height: 20)
                    .clipped()
                Text(gitRepo.pushedAt ?? "")
                    .font(.body)
            }
        }
    }
}

struct RepoDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepoDetailsView(gitRepo: RepoListModelElement(id: 1, nodeID: "", name: "Text", fullName: "", repoListModelPrivate: false, owner: nil, htmlURL: nil, repoListModelDescription: "Some type of descriptions...", fork: false, url: nil, forksURL: nil, keysURL: nil, collaboratorsURL: nil, teamsURL: nil, hooksURL: nil, issueEventsURL: nil, eventsURL: nil, assigneesURL: nil, branchesURL: nil, tagsURL: nil, blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil, treesURL: nil, statusesURL: nil, languagesURL: nil, stargazersURL: nil, contributorsURL: nil, subscribersURL: nil, subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil, commentsURL: nil, issueCommentURL: nil, contentsURL: nil, compareURL: nil, mergesURL: nil, archiveURL: nil, downloadsURL: nil, issuesURL: nil, pullsURL: nil, milestonesURL: nil, notificationsURL: nil, labelsURL: nil, releasesURL: nil, deploymentsURL: nil, createdAt: nil, updatedAt: nil, pushedAt: "2016-11-18T04:59:10Z", gitURL: nil, sshURL: nil, cloneURL: nil, svnURL: nil, homepage: nil, size: nil, stargazersCount: nil, watchersCount: nil, language: "Swift", hasIssues: nil, hasProjects: nil, hasDownloads: nil, hasWiki: nil, hasPages: nil, forksCount: nil, mirrorURL: nil, archived: nil, disabled: nil, openIssuesCount: nil, license: nil, forks: nil, openIssues: nil, watchers: nil, defaultBranch: nil))
    }
}
