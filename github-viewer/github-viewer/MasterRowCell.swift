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
    
    var item: RepoItem? {
        didSet {
            textLabel.text = item?.title
        }
    }
    
    private var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        contentView.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
