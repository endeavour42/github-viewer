//
//  RepoItem.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

struct RepoItem: Hashable {
    let name: String
    let description: String
    let language: String
    let forks: Int
    let stars: Int
    let date: Date
}
