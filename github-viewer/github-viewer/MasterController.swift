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
    var items: [RepoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let controllers = splitViewController!.viewControllers
        detailController = (controllers.last as! UINavigationController).topViewController as? DetailController
        
        insertNewObject()
        insertNewObject()
        insertNewObject()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    func insertNewObject() {
        items.insert(RepoItem(name: String(temp)), at: 0)
        temp += 1
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

// MARK: Segue

extension MasterController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let item = items[indexPath.row]
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
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = items[indexPath.row]
        cell.textLabel!.text = item.name
        return cell
    }
}

