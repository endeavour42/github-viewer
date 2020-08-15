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
    func isContained(in strings: [String?]) -> Bool {
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

private let testCache = false

extension URLSessionConfiguration {
    static let cachingConfiguration: URLSessionConfiguration = {
        let config: URLSessionConfiguration = .default
        config.requestCachePolicy = testCache ? .returnCacheDataDontLoad : .returnCacheDataElseLoad
        return config
    }()
}

extension URLSession {
    func loadImage(from url: URL, execute: @escaping (_ image: UIImage?) -> Void) {
        dataTask(with: url) { data, response, error in
            execute(data != nil && error == nil ? UIImage(data: data!) : nil)
        }.resume()
    }
    
    static let cachingSession = URLSession(configuration: .cachingConfiguration)
}

extension UIImage {
    static let empty = UIImage()
}

extension Date {
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}
