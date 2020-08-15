//
//  RepoItem.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

struct RepoItem: Identifiable, Hashable, Codable {
    
    struct Owner: Identifiable, Hashable, Codable {
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
    init?(fromJsonData jsonData: Data) {
        guard let v = try? JSONDecoder().decode(RepoItem.self, from: jsonData) else {
            return nil
        }
        self = v
    }
    
    func toJsonData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

struct RepoResult: Decodable {
    let items: [RepoItem]
    
    init(fromJsonData jsonData: Data) throws {
        do {
            self = try JSONDecoder().decode(RepoResult.self, from: jsonData)
        } catch {
            throw error
        }
    }
}
