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
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(favorites) { artwork in
                        NavigationLink(destination: ArtworkDetailView(artwork: artwork.toArtwork())) {
                            ArtworkView(artwork: artwork.toArtwork())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Favorites")
        }
    }
}
