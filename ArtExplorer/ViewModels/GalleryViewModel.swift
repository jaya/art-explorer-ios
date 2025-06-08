//
//  GalleryViewModel.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var viewState: ViewState = .loading
    private var artworkCollection: ArtworkCollection?
    private var artworks: [Artwork] = []

    func loadArtworks() async {
        do {
            artworkCollection = try await ArtAPIService.shared.fetchArtworks()
        } catch {
            let errorMessage = "Error loading artworks: \(error)"
            viewState = .error(errorMessage)
        }
    }

    func loadArtworksDetails() async {
        do {
            for i in artworks.count...artworks.count+15 {
                if let objectID = artworkCollection?.objectIDs?[i] {
                    let artwork = try await ArtAPIService.shared.fetchArtworksDetails(objectID: "\(objectID)")
                    artworks.append(artwork)
                }
            }
            viewState = .normal(artworks)
        } catch {
            let errorMessage = "Error loading artworks: \(error)"
            viewState = .error(errorMessage)
        }
    }
}
