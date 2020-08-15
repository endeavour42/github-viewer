//
//  MasterController.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

var temp: Int = 0 // TODO: remove later

class MasterController: UITableViewController {

    var detailController: DetailController?
    
    var model: RepoModel { RepoModel.singleton }

    override func viewDidLoad() {
        super.viewDidLoad()

        let controllers = splitViewController!.viewControllers
        detailController = (controllers.last as! UINavigationController).topViewController as? DetailController
        
        NotificationCenter.default.addObserver(forName: model.changedNotification, object: nil, queue: nil) { _ in
            self.tableView.reloadData() // REDO
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
}

// MARK: Segue

extension MasterController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item = model.items[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailController
                controller.item = item
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

// MARK: TableDataSource

extension MasterController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = model.items[indexPath.row]
        cell.textLabel!.text = item.name
        return cell
    }
}

