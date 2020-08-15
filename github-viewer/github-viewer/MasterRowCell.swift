//
//  MasterRowCell.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

class MasterRowCell: UICollectionViewCell {
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textLabel.text = "xxx"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
