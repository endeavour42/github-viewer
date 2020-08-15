//
//  RepoItem.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

struct RepoItem: Identifiable, Hashable, Decodable {
    
    struct Owner: Identifiable, Hashable, Decodable {
        let id: Int
        let login: String
        let avatar_url: String?
    }
    
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let language: String?
    let forks: Int
    let created_at: String // e.g. "2020-08-13T01:01:58Z",
    let html_url: String
    let owner: Owner
    
    private static let dateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd'T'HH:mm:ssZ")

    var title: String {
        login + "/" + name
    }
    
    var login: String {
        owner.login
    }
    
    var createdDate: Date {
        RepoItem.dateFormatter.date(from: created_at)!
    }
    
    var avatarUrl: URL? {
        guard let string = owner.avatar_url else { return nil }
        return URL(string: string)
    }
    
    var htmlUrl: URL? {
        URL(string: html_url)
    }
}

struct RepoResult: Decodable {
    let items: [RepoItem]
}
