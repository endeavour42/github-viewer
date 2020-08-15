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
            .font(.title)
            .padding()
    }
}

struct FooterView: View {
    var body: some View {
            HStack() {
                Spacer()
                Button(action: {
                    print("action")
                }) {
                    Text(localized(.open))
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
    var iconKey: SystemIconKey
    var title: String
    
    var body: some View {
        HStack {
            Image(iconKey).resizable().frame(width: 18, height: 18)
            Text(title)
        }
    }
}

struct DetailView: View {
    let item: RepoItem
    
    var body: some View {
        List {
            HeaderView(title: item.description)
            RowView(iconKey: .language, title: item.language)
            RowView(iconKey: .forks, title: String(format: localized(.forksFormat), item.forks))
            RowView(iconKey: .stars, title: String(format: localized(.starsFormat), item.stars))
            RowView(iconKey: .date, title: String(format: localized(.dateFormat), 123, "456"))
            FooterView()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: RepoItem(name: "name", description: "desc", language: "lang", forks: 1, stars: 2, date: Date()))
    }
}
