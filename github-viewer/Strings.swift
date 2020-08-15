//
//  Strings.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import Foundation

enum StringKey: String {
    case repositories
    case favourites
    case noLanguage
    case noDescription
    case forksFormat
    case starsFormat
    case dateFormat
    case daysAgoFormat
    case openInGitHub
    case day
    case month
    case year
}

private let testStrings = false

func localized(_ key: StringKey) -> String {
    let string = NSLocalizedString(key.rawValue, comment: "")
    return testStrings ? string.uppercased() : string
}
