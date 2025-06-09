//
//  FavoritesView.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import SwiftUI
import Kingfisher
import SwiftData

struct FavoritesView: View {
    @Query private var favorites: [ArtworkModel]
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            favoritesList
                .navigationTitle("Favorites")
        }
    }

    private var favoritesList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(favorites) { artwork in
                    favoriteItem(for: artwork)
                }
            }
            .padding(.top)
        }
    }

    private func favoriteItem(for artwork: ArtworkModel) -> some View {
        NavigationLink(
            destination: ArtworkDetailView(
                viewModel: ArtworkDetailViewModel(
                    artwork: artwork.toArtwork(),
                    context: context
                )
            )
        ) {
            ArtworkView(artwork: artwork.toArtwork())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
