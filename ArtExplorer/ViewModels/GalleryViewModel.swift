//
//  GalleryViewModel.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation

enum ViewState {
    case loading
    case error
    case normal
}

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var artworks: [ArtworkData] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func loadArtworks() async {
        isLoading = true
        do {
            artworks = try await ArtAPIService.shared.fetchArtworks()
        } catch {
            errorMessage = "Error loading artworks: \(error)"
        }
        isLoading = false
    }
}
