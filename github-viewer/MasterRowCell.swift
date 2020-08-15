//
//  MasterRowCell.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit
import SwiftUI

class MasterRowCell: UICollectionViewCell {
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    private var vc: UIViewController!
    
    var item: RepoItem? {
        didSet {
            vc?.view?.removeFromSuperview()
            vc = nil
            
            if let item = item {
                vc = UIHostingController(rootView: MasterRowView(item: item))
                let v = vc.view!
                v.frame = contentView.bounds
                v.autoresizingMask = .flexibleSize
                v.translatesAutoresizingMaskIntoConstraints = true
                contentView.addSubview(v)
            }
        }
    }
}
