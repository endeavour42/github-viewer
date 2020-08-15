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
    
    typealias DataSource = UITableViewDiffableDataSource<String, RepoItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, RepoItem>
    
    enum Segues: String {
        case showDetail
    }

    @IBOutlet weak var tableView: UITableView!
    
    private var detailController: DetailController?
    private var dataSource: DataSource!

    var model: RepoModel { RepoModel.singleton }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        
        dataSource = DataSource(tableView: tableView, cellProvider: cellProvider)
        dataSource.defaultRowAnimation = .fade
        
        let controllers = splitViewController!.viewControllers
        detailController = (controllers.last as! UINavigationController).topViewController as? DetailController
        
        NotificationCenter.default.addObserver(forName: model.changedNotification, object: nil, queue: nil) { _ in
            self.applyModelChanges()
        }
        applyModelChanges()
    }
    
    private func applyModelChanges() {
        self.tableView.reloadData() // REDO
        
        var snapshot = Snapshot()
        snapshot.appendSections(["rows"])
        snapshot.appendItems(model.items)
        dataSource.apply(snapshot)
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

extension MasterController {
    private func cellProvider(_ tableView: UITableView, _ indexPath: IndexPath, _ item: RepoItem) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = item.name
        return cell
    }
}

extension MasterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segues.showDetail.rawValue, sender: nil)
    }
}
