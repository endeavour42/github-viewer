//
//  RepoModel.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

class RepoModel {
    
    static let singleton = RepoModel()
    
    let changedNotification = Notification.Name("RepoModel.changedNotification")
    
    private init() {
        insertNewObject()
        insertNewObject()
        insertNewObject()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.insertNewObject()
        }
    }
    
    var items: [RepoItem] = []
    
    private func insertNewObject() {
        items.insert(RepoItem(title: String(temp), subtitle: "subtitle"), at: 0)
        temp += 1
        NotificationCenter.default.post(name: changedNotification, object: self, userInfo: nil)
    }
}
