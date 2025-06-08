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
                ForEach(artworks.indices, id: \.self) { index in
                    let artwork = artworks[index]
                    Text("\(artwork)")
                        .onAppear {
                            if index == artworks.count - 1 {
                                Task {
                                    await viewModel.loadArtworksDetails()
                                }
                            }
                        }
                }
            }
        }
    }

}

#Preview {
    GalleryView()
}
