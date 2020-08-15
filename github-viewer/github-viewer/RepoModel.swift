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
    private var repoItems: [RepoItem] = []

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
        insertNewObject()
        insertNewObject()
        insertNewObject()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.insertNewObject()
        }
    }
    
    private func insertNewObject() {
        let repo = RepoItem(name: String(temp), description: "desc", language: "lang", forks: 1, stars: 2, date: Date())
        repoItems.insert(repo, at: 0)
        temp += 1
        changed()
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
