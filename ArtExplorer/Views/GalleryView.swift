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
            switch viewModel.viewState {
            case .loading:
                ProgressView()
            case .error(let error):
                Text(error ?? "Error")
            case .normal(let artworks):
                setArtworks(artworks)
            }
        }
        .task {
            await viewModel.loadArtworks()
            await viewModel.loadArtworksDetails()
        }
    }

    func setArtworks(_ artworks: [Artwork]) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(artworks.indices), id: \.self) { index in
                    setArtwork(artworks, index: index)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    @ViewBuilder
    func setArtwork(_ artworks: [Artwork], index: Int) -> some View {
        let artwork = artworks[index]
        ArtworkView(artwork: artwork)
            .onAppear {
                if index == artworks.count - 1 {
                    Task {
                        await viewModel.loadArtworksDetails()
                    }
                }
            }
    }
}

#Preview {
    GalleryView()
}
