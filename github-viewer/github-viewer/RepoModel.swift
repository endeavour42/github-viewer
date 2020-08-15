//
//  RepoModel.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

class RepoModel: ObservableObject {
    
    enum Domain: Int {
        case repositories, favourites
    }
    
    enum Period: Int {
        case day, month, year
    }
    
    static let singleton = RepoModel()
    
    let changedNotification = Notification.Name("RepoModel.changedNotification")
    
    @Published private var favouriteItems: [RepoItem] = []
    
    private var repoItems: [RepoItem] = [] {
        didSet { changed() }
    }

    var items: [RepoItem] {
        domain == .repositories ? repoItems : favouriteItems
    }
    
    var domain: Domain = .repositories {
        didSet { changed() }
    }
    
    var period: Period = .day {
        didSet { changed() }
    }

    private init() {
        loadMoreItems()
    }
    
    func loadMoreItems(execute: (() -> Void)? = nil) {
        if domain == .repositories {
            URLSession.shared.loadRepos(since: Date() - 100500) { items in
                self.repoItems.insert(contentsOf: items, at: 0)
                execute?()
            }
        } else {
            execute?()
        }
    }
    
    private func changed() {
        NotificationCenter.default.post(name: changedNotification, object: self, userInfo: nil)
    }
}

extension RepoModel {
    func isFavourite(_ item: RepoItem) -> Bool {
        favouriteItems.contains(item)
    }
    
    func toggleFavourite(_ item: RepoItem) {
        if isFavourite(item) {
            favouriteItems.removeAll { $0 == item }
        } else {
            favouriteItems.append(item)
        }
        changed()
    }
}
