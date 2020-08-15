//
//  Icons.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

enum SystemIconKey: String {
    case bookmark
    case chevron_right = "chevron.right"
    
    case language = "command"
    case forks = "arrow.branch"
    case stars = "star"
    case date = "clock"
}

extension Image {
    init(_ key: SystemIconKey) {
        self.init(systemName: key.rawValue)
    }
}
