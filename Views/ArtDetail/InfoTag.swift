//
//  InfoTag.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import SwiftUI

public struct InfoTag: View {
    private let title: String
    private let value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
    
    public var body: some View {
        HStack {
            Text(title + ":")
                .font(.caption.bold())
                .foregroundColor(.gray)
            Text(value)
                .font(.caption)
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

