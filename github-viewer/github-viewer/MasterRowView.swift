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
    
    var body: some View {
        HStack {
            Image(systemName: "command")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "bookmark")
            Image(systemName: "chevron.right")
        }.padding()
    }
}

struct MasterRowView_Previews: PreviewProvider {
    static var previews: some View {
        MasterRowView(item: RepoItem(title: "title", subtitle: "subtleHere"))
    }
}
