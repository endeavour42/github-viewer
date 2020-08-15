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
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<String, RepoItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<String, RepoItem>
    
    private let showDetail = "showDetail"

    private var detailController: DetailController?
    private var dataSource: DataSource!

    var model: RepoModel { RepoModel.singleton }
    
    private var searchText: String? {
        didSet {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        collectionView.register(MasterRowCell.self, forCellWithReuseIdentifier: MasterRowCell.identifier)
        collectionView.delegate = self
        //collectionView.backgroundColor = .systemBackground
        //view.addSubview(collectionView)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        
        let controllers = splitViewController!.viewControllers
        detailController = (controllers.last as! UINavigationController).topViewController as? DetailController
        
        setupSearch()
        
        NotificationCenter.default.addObserver(forName: model.changedNotification, object: nil, queue: nil) { _ in
            self.applyModelChanges()
        }
        applyModelChanges()
    }
    
    private func applyModelChanges() {
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
        if segue.identifier == showDetail {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let item = model.items[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailController
                controller.item = item
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}

// MARK: CollectionView

extension MasterController {
    private func cellProvider(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ item: RepoItem) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MasterRowCell.identifier, for: indexPath) as! MasterRowCell
        cell.item = item
        return cell
    }
}

extension MasterController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: showDetail, sender: nil)
    }
}

extension MasterController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 90)
    }
}

// MARK: Search

extension MasterController {
    private func setupSearch() {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        let sb = sc.searchBar
        sb.delegate = self
        sb.scopeButtonTitles = ["day", "month", "year"]
        sb.showsScopeBar = true
        
        navigationItem.searchController = sc
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MasterController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchString: String) {
        searchText = searchString
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchText = nil
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
}
