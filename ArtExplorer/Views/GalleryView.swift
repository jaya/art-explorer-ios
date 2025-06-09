//
//  GalleryView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI

struct GalleryView: View {
    @Environment(\.modelContext) private var context
    @StateObject var viewModel = GalleryViewModel()

    var body: some View {
        NavigationStack {
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
            }
        }
    }

    func setArtworks(_ artworks: [Artwork]) -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(Array(artworks.enumerated()), id: \.offset) { index, artwork in
                    setArtwork(artwork, artworks: artworks, index: index)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }

    @ViewBuilder
    func setArtwork(_ artwork: Artwork, artworks: [Artwork],  index: Int) -> some View {
        NavigationLink(destination: ArtworkDetailView(viewModel: ArtworkDetailViewModel(artwork: artwork, context: context))) {
            ArtworkView(artwork: artwork)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if index == artworks.count - 5 {
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
