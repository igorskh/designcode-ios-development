//
//  PostList.swift
//  design-n-code
//
//  Created by Igor Kim on 15.12.20.
//

import SwiftUI

struct PostList: View {
    @ObservedObject var store = DataStore()
    @State var posts: [Post] = []
    
    var body: some View {
        List(store.posts) { post in
            VStack(alignment: .leading, spacing: 8) {
                Text(post.title).font(.system(.title, design: .serif)).bold()
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
