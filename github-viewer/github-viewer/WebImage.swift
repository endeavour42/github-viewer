//
//  WebImage.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

class WebImageLoader: ObservableObject {
    
    @Published private (set) var image: UIImage?
    
    func load(_ url: URL) {
        URLSession.shared.loadImage(from: url) { image in
            onMainThread {
                self.image = image
            }
        }
    }
}

struct WebImage: View {
    
    @ObservedObject private var loader = WebImageLoader()
    
    private let placeholder: Image
    
    init(_ url: URL, placeholder: Image = Image(uiImage: .empty)) {
        self.placeholder = placeholder
        loader.load(url)
    }
    
    var body: some View {
        guard let image = loader.image else {
            return placeholder.resizable()
        }
        return Image(uiImage: image).resizable()
    }
}
