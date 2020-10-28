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
    
    func loadRepos(from fromUrl: URL?, since: Date, itemCountPerPage: Int = 50, execute: @escaping ([RepoItem], _ nextUrl: URL?, Error?) -> Void) {
        
        func makeNewUrl() -> URL? {
            let dateString = URLSession.repoDateFormatter.string(from: since)
            
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = "/search/repositories"
            
            let queryItems = [
                "q" : "created:>" + dateString,
                "sort" : "stars",
                "order" : "desc",
                "accept" : "application/vnd.github.v3+json",
                "per_page" : String(itemCountPerPage)
            ]
            components.queryItems = queryItems.map { URLQueryItem(name: $0, value: $1) }
            return components.url
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

        guard let url = fromUrl ?? makeNewUrl() else {
            execute([], nil, NSError(domain: "URL Error", code: -1, userInfo: nil))
            return
        }
        
        startDataTask(with: url) { data, response, err in
            
            guard let data = data, err == nil else {
                execute([], nil, err)
                return
            }
            
            let repoResult: RepoResult
            
            do {
                repoResult = try RepoResult(fromJsonData: data)
            } catch {
                execute([], nil, error)
                return
            }
            let nextUrl = parseNextUrl(from: response)
            execute(repoResult.items, nextUrl, nil)
        }
    }
}
