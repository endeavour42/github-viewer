//
//  DetailView.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .padding()
    }
}

struct FooterView: View {
    let url: URL?
    
    var body: some View {
            HStack() {
                Spacer()
                Button(action: {
                    if let url = self.url {
                        UIApplication.shared.open(url, options: [:])
                    }
                }) {
                    Text(localized(.openInGitHub))
                }
                .padding(20)
                .background(Color.blue)
                .cornerRadius(10)
                Spacer()
            }
        .padding()
    }
}

struct RowView: View {
    let iconKey: SystemIconKey
    let title: String
    
    var body: some View {
        HStack {
            Image(iconKey)
                .resizable()
                .frame(width: 18, height: 18)
            Text(title)
        }
    }
}

struct DetailView: View {
    let item: RepoItem!
    
    var body: some View {
        List {
            if item != nil {
                HeaderView(title: item.description ?? localized(.noDescription))
                RowView(iconKey: .language, title: item.language ?? localized(.noLanguage))
                RowView(iconKey: .forks, title: String(format: localized(.forksFormat), item.forks))
                RowView(iconKey: .stars, title: String(format: localized(.starsFormat), item.stargazers_count))
                RowView(iconKey: .date, title: String(format: localized(.dateFormat), 123, "456"))
                FooterView(url: item.htmlUrl)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let item = RepoItem(id: 1, name: "name", description: "desc", stargazers_count: 1, language: "lang", forks: 2, created_at: "2020-01-01T01:01:01Z", html_url: "111", owner: RepoItem.Owner(id: 1, login: "login", avatar_url: nil))
        
        return DetailView(item: item)
    }
}
