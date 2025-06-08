//
//  GalleryView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel = GalleryViewModel()

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.errorMessage {
                Text(error)
            } else {
                ScrollView {
                    ForEach(viewModel.artworks) { artwork in
                        Text(artwork.title)
                            .font(.headline)
                    }
                }
            }
        }
        .task {
            await viewModel.loadArtworks()
        }
    }
}

#Preview {
    GalleryView()
}
