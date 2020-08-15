//
//  DetailView.swift
//  github-viewer
//
//  Created by Mike on 15/08/2020.
//  Copyright © 2020 Mike Kluev. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        List {
            Text("some long text will be here this is a description that overlaps over a few lines")
                .font(.title)
                .padding()
            
            Text("first")
            Text("second")
            Text("third")
            Text("fourth")
            
            HStack() {
                Spacer()
                Button(action: {
                    print("action")
                }) {
                    Text("Open in GitHub")
                }
                .padding(20)
                .background(Color.blue)
                .cornerRadius(10)
                Spacer()
            }
        .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
