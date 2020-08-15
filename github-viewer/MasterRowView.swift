//
//  MasterRowView.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

struct MasterRowView: View {
    let item: RepoItem
    @ObservedObject private var model = RepoModel.singleton
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                
                WebImage(item.avatarUrl!)
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: ContentMode.fill)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(item.description ?? localized(.noDescription))
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.secondary)
                    Text(String(format: localized(.daysAgoFormat), item.daysAgo, item.stargazers_count))
                        .font(.subheadline)
                        .lineLimit(2)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    RepoModel.singleton.toggleFavourite(self.item)
                }) {
                    Image(model.isFavourite(item) ? .selectedBookmark : .bookmark)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                
                Image(.disclosureTriangle)
            }
            Divider()
        }
        .padding()
    }
}

struct MasterRowView_Previews: PreviewProvider {
    static var previews: some View {
        let item = RepoItem(id: 1, name: "name", description: "desc", stargazers_count: 1, language: "lang", forks: 2, created_at: "2020-01-01T01:01:01Z", html_url: "111", owner: RepoItem.Owner(id: 1, login: "login", avatar_url: nil))

        return MasterRowView(item: item)
    }
}
