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
    @ObservedObject var model = RepoModel.singleton
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(.language)
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(item.description ?? localized(.noDescription))
                        .font(.subheadline)
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
        let item = RepoItem(name: "name", description: "desc", stargazers_count: 1, language: "lang", forks: 2, created_at: "2020-01-01T01:01:01Z", html_url: "111", owner: RepoItem.Owner(login: "login", avatar_url: nil))

        return MasterRowView(item: item)
    }
}
