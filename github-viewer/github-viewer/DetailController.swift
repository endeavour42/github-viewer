//
//  DetailController.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!

    func configureView() {
        detailLabel?.text = item?.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var item: RepoItem? {
        didSet {
            configureView()
        }
    }
}

