//
//  Extensions.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import UIKit

extension UIView.AutoresizingMask {
    static let flexibleSize: UIView.AutoresizingMask = [.flexibleWidth, .flexibleHeight]
}

extension String {
    func contained(in strings: [String?]) -> Bool {
        guard !isEmpty else { return true }
        return strings.contains { $0?.localizedCaseInsensitiveContains(self) ?? false }
    }
}

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

func onMainThread(execute: @escaping () -> Void) {
    if Thread.isMainThread {
        execute()
    } else {
        DispatchQueue.main.async(execute: execute)
    }
}
