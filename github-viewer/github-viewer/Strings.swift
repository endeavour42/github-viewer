//
//  Strings.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

enum StringKey: String {
    case forksFormat = "%d Forks"
    case starsFormat = "%d Stars"
    case dateFormat = "Created %d years ago at %@"
    case open = "Open in GitHub"
    case day
    case month
    case year
    case noLanguage = "No language"
    case noDescription = "No description"
}

func localized(_ key: StringKey) -> String {
    NSLocalizedString(key.rawValue, comment: "").uppercased()
}
