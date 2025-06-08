//
//  ArtworkView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI
import Kingfisher

struct ArtworkView: View {
    let imageURL: URL?

    var body: some View {
        VStack {
            KFImage(imageURL)
                .placeholder {
                    ProgressView()
                        .frame(height: 250)
                }
                .cancelOnDisappear(true)
                .resizable()
                .scaledToFill()
                .frame(height: 250)
                .clipped()
                .cornerRadius(8)
                .padding()
        }
    }
}
