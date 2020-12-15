//
//  DataStore.swift
//  design-n-code
//
//  Created by Igor Kim on 15.12.20.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
