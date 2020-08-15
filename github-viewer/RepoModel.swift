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
    
    private var nextUrl: URL?
    
    @Published private var favouriteItems: [RepoItem] = []
    
    private var repoItems: [RepoItem] = [] {
        didSet { changed() }
    }

    var items: [RepoItem] {
        domain == .repositories ? repoItems : favouriteItems
    }
    
    var domain: Domain = .repositories {
        didSet {
            guard domain != oldValue else { return }
            changed()
        }
    }
    
    var period: Period = .day {
        didSet {
            guard period != oldValue else { return }
            
            if domain == .repositories {
                nextUrl = nil
                repoItems = []
                loadMoreItems()
            } else {
                changed()
            }
        }
    }

    private init() {
        loadMoreItems()
    }
    
    func loadMoreItems(execute: (() -> Void)? = nil) {
        if domain == .repositories {
            URLSession.caching.loadRepos(from: nextUrl, since: Date() - period.timeInterval) { items, nextUrl in
                self.nextUrl = nextUrl
                var newItems = items
                newItems.removeAll { it in
                    self.repoItems.contains { $0.id == it.id }
                }
                self.repoItems.insert(contentsOf: newItems, at: 0)
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

// TODO: redo later
extension RepoModel.Period {
    var timeInterval: TimeInterval {
        switch self {
        case .day: return 24*60*60
        case .month: return 30 * RepoModel.Period.day.timeInterval
        case .year: return 365 * RepoModel.Period.day.timeInterval
        }
    }
}
