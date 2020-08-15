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
    
    var daysAgo: Int {
        Int(Date().timeIntervalSince(createdDate) / RepoModel.Period.day.timeInterval)
    }
    
    var avatarUrl: URL? {
        guard let string = owner.avatar_url else { return nil }
        return URL(string: string)
    }
    
    var htmlUrl: URL? {
        URL(string: html_url)
    }
}

extension RepoItem {
    init(_ v: [String: Any]) {
        self.init(
            id: v["id"] as! Int,
            name: v["name"] as! String,
            description: v["description"] as? String,
            stargazers_count: v["stargazers_count"] as! Int,
            language: v["language"] as? String,
            forks: v["forks"] as! Int,
            created_at: v["created_at"] as! String,
            html_url: v["html_url"] as! String,
            owner: Owner(v["owner"] as! [String: Any])
        )
    }
    var dictionary: [String: Any] {
        var v: [String: Any] = [:]
        v["id"] = id
        v["name"] = name
        v["description"] = description
        v["stargazers_count"] = stargazers_count
        v["language"] = language
        v["forks"] = forks
        v["created_at"] = created_at
        v["html_url"] = html_url
        v["owner"] = owner.dictionary
        return v
    }
}

extension RepoItem.Owner {
    init(_ v: [String: Any]) {
        self.init(
            id: v["id"] as! Int,
            login: v["login"] as! String,
            avatar_url: v["avatar_url"] as? String
        )
    }
    
    var dictionary: [String: Any] {
        var v: [String: Any] = [:]
        v["id"] = id
        v["login"] = login
        v["avatar_url"] = avatar_url
        return v
    }
}

struct RepoResult: Decodable {
    let items: [RepoItem]
}
