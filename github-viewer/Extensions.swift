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
    class func makeWith(policy: URLRequest.CachePolicy) -> URLSessionConfiguration {
        let v = URLSessionConfiguration.default
        v.requestCachePolicy = policy
        return v
    }
    static let caching: URLSessionConfiguration = .makeWith(policy: .returnCacheDataElseLoad)
    static let revalidating: URLSessionConfiguration = .makeWith(policy: .reloadRevalidatingCacheData)
}

extension URLSession {
    func loadImage(from url: URL, execute: @escaping (_ image: UIImage?) -> Void) {
        startDataTask(with: url) { data, response, error in
            execute(data != nil && error == nil ? UIImage(data: data!) : nil)
        }
    }
    
    @discardableResult
    func startDataTask(with url: URL, execute: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: url) { data, response, error in
            NetworkActivity.singleton.stop()
            execute(data, response, error)
        }
        NetworkActivity.singleton.start()
        task.resume()
        return task
    }
    
    static let caching = URLSession(configuration: .caching)
    static let revallidating = URLSession(configuration: .revalidating)
}

class NetworkActivity {
    
    static let singleton = NetworkActivity()
    private init() {}
    
    private var isActive: Bool = false {
        didSet {
            if isActive != oldValue {
                UIApplication.shared.isNetworkActivityIndicatorVisible = isActive // FIX deprecation later
            }
        }
    }
    
    private var count = 0 {
        didSet {
            onMainThread {
                self.isActive = self.count != 0
            }
        }
    }
    
    func start() {
        count += 1
    }
    
    func stop() {
        count -= 1
    }
}

extension UIImage {
    static let empty = UIImage()
}

extension Date {
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}
