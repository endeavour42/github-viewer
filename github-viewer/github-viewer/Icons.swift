//
//  Icons.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

enum SystemIconKey: String {
    case command
    case bookmark
    case chevron_right = "chevron.right"
}

extension Image {
    init(_ key: SystemIconKey) {
        self.init(systemName: key.rawValue)
    }
}
