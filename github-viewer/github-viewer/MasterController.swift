//
//  MasterController.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

class MasterController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tabBar: UITabBar!

    private typealias DataSource = UICollectionViewDiffableDataSource<String, RepoItem>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<String, RepoItem>
    
    private var dataSource: DataSource!
    
    private var detailController: DetailController?
    private let showDetailSegue = "showDetail"

    private var model: RepoModel { RepoModel.singleton }
    
    private var searchText: String? {
        didSet {
            applyModelChanges()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = localized(.repositories)
        
        let controllers = splitViewController!.viewControllers
        detailController = (controllers.last as! UINavigationController).topViewController as? DetailController
        
        setupCollectionView()
        setupSearch()
        setupTabBar()
        setupRefreshControl()

        NotificationCenter.default.addObserver(forName: model.changedNotification, object: nil, queue: nil) { _ in
            self.applyModelChanges()
        }
        applyModelChanges()
    }
    
    private func setupCollectionView() {
        collectionView.register(MasterRowCell.self, forCellWithReuseIdentifier: MasterRowCell.identifier)
        collectionView.delegate = self
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
    }
    
    private func applyModelChanges() {
        let items = model.items
            .filter { searchText?.contained(in: [$0.name, $0.description]) ?? true }
        
        var snapshot = Snapshot()
        snapshot.appendSections(["rows"])
        snapshot.appendItems(items)
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
        if segue.identifier == showDetailSegue {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let item = dataSource.snapshot().itemIdentifiers[indexPath.row]
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
        performSegue(withIdentifier: showDetailSegue, sender: nil)
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
        sb.scopeButtonTitles = [localized(.day), localized(.month), localized(.year)]
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
        model.period = RepoModel.Period(rawValue: selectedScope)!
    }
}

// MARK: TabBar

extension MasterController {
    private func setupTabBar() {
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items!.first!
    }
}

extension MasterController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        model.domain = RepoModel.Domain(rawValue: item.tag)!
    }
}

// MARK: setupRefreshControl

extension MasterController {
    
    private func setupRefreshControl() {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        collectionView.refreshControl = rc
    }
    
    @objc private func refreshAction(_ rc: UIRefreshControl) {
        model.loadMoreItems() {
            onMainThread {
                rc.endRefreshing()
            }
        }
    }
}
