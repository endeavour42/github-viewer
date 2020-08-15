//
//  RepoLoader.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

extension URLSession {
    func loadRepos(url: URL, execute: @escaping ([RepoItem]) -> Void) {
        
        dataTask(with: url) { data, response, error in
            let repoResult = try! JSONDecoder().decode(RepoResult.self, from: data!)
            execute(repoResult.items)
        }.resume()
    }
}
