//
//  RepoLoader.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

extension URLSession {
    private static let repoDateFormatter = DateFormatter(dateFormat: "yyyy-MM-dd")
    
    func loadRepos(since: Date, execute: @escaping ([RepoItem]) -> Void) {
        
        func makeUrl() -> URL {
            let dateString = URLSession.repoDateFormatter.string(from: since)
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = "/search/repositories"
            
            components.queryItems = [
                URLQueryItem(name: "q", value: "created:>" + dateString),
                URLQueryItem(name: "sort", value: "stars"),
                URLQueryItem(name: "order", value: "desc"),
                URLQueryItem(name: "accept", value: "application/vnd.github.v3+json"),
                URLQueryItem(name: "per_page", value: String(3))
            ]
            return components.url!
        }
        
        let url = makeUrl()
        
        dataTask(with: url) { data, response, error in
            let repoResult = try! JSONDecoder().decode(RepoResult.self, from: data!)
            execute(repoResult.items)
        }.resume()
    }
}
