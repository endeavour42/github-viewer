//
//  DetailController.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit
import SwiftUI

class DetailController: UIViewController {

    private var vc: UIViewController!

    var item: RepoItem? {
        didSet {
            vc?.removeFromParent()
            vc?.view?.removeFromSuperview()
            vc = nil
            
            if let item = item {
                vc = UIHostingController(rootView: DetailView(item: item))
                addChild(vc)
                let v = vc.view!
                v.frame = view.bounds
                v.autoresizingMask = .flexibleSize
                view.addSubview(v)
            }
        }
    }
}

