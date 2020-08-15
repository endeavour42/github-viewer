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
        let navController = svc.viewControllers.last as! UINavigationController
        navController.topViewController!.navigationItem.leftBarButtonItem = svc.displayModeButtonItem
        svc.delegate = self
        return true
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, collapseSecondary secondaryVC: UIViewController, onto: UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryVC as? UINavigationController else { return false }
        guard let detailVC = secondaryAsNavController.topViewController as? DetailController else { return false }
        if detailVC.item == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
}
