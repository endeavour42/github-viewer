//
//  MasterController.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

var temp: Int = 0 // TODO: remove later

class MasterController: UIViewController {
    
    enum Segues: String {
        case showDetail
    }

    @IBOutlet weak var tableView: UITableView!
    
    private var detailController: DetailController?

    var model: RepoModel { RepoModel.singleton }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self

        let controllers = splitViewController!.viewControllers
        detailController = (controllers.last as! UINavigationController).topViewController as? DetailController
        
        NotificationCenter.default.addObserver(forName: model.changedNotification, object: nil, queue: nil) { _ in
            self.tableView.reloadData() // REDO
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
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

// MARK: TableView

extension MasterController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = model.items[indexPath.row]
        cell.textLabel!.text = item.name
        return cell
    }
}

extension MasterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.showDetail.rawValue, sender: nil)
    }
}
