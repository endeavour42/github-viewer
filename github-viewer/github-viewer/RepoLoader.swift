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
    
    func loadRepos(fromUrl: URL?, since: Date, execute: @escaping ([RepoItem], _ nextUrl: URL?) -> Void) {
        
        func makeNewUrl() -> URL {
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
        
        func parseNextUrl(from response: URLResponse?) -> URL?  {
            let r = response as! HTTPURLResponse
            let link = r.value(forHTTPHeaderField: "link")
            let comps1 = link?.components(separatedBy: #">; rel="next"#)
            let head = comps1?.first
            let comps2 = head?.components(separatedBy: "<")
            let that = comps2?.last
            let nextUrl = head != nil ? URL(string: that!) : nil
            print("nextUrl: \(nextUrl)")
            return nextUrl
        }

        let url = fromUrl ?? makeNewUrl()
        
        dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                execute([], nil)
                return
            }
            guard let repoResult = try? JSONDecoder().decode(RepoResult.self, from: data) else {
                execute([], nil)
                return
            }
            let nextUrl = parseNextUrl(from: response)
            execute(repoResult.items, nextUrl)
        }.resume()
    }
}
