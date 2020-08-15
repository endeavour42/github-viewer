//
//  AppDelegate.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
}

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let svc = window!.rootViewController as! UISplitViewController
        svc.preferredDisplayMode = .allVisible
        let nav = svc.viewControllers.last as! UINavigationController
        nav.topViewController!.navigationItem.leftBarButtonItem = svc.displayModeButtonItem
        svc.delegate = self
        
        UITableView.appearance().tableFooterView = UIView()
        
        URLCache.shared.diskCapacity = 50_000_000
        URLCache.shared.memoryCapacity = 50_000_000
        
        return true
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, collapseSecondary secondaryVC: UIViewController, onto: UIViewController) -> Bool {
        guard let nav = secondaryVC as? UINavigationController else { return false }
        guard let detailController = nav.topViewController as? DetailController else { return false }
        if detailController.item == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}
