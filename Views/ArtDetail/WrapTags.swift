//
//  WrapTags.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import SwiftUI

public struct WrapTags: View {
    private let tags: [String]
    
    init(tags: [String]) {
        self.tags = tags
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Tags")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 8)]) {
                ForEach(tags, id: \ .self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(6)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(6)
                }
            }
        }
    }
}
