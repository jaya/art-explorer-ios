//
//  GalleryViewModel.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var viewState: ViewState<[Artwork]> = .loading

    private var artworkCollection: ArtworkCollection?
    private var artworks: [Artwork] = []
    private let batchSize = 15

    func loadArtworks() async {
        do {
            artworkCollection = try await NetworkService.shared.request(
                endpoint: MetMuseumAPI.searchArtworks(query: "painting"),
                responseType: ArtworkCollection.self
            )
            await loadArtworksDetails()
        } catch {
            viewState = .error("Failed to load artworks: \(error.localizedDescription)")
        }
    }

    func loadArtworksDetails() async {
        guard let ids = artworkCollection?.objectIDs else {
            viewState = .error("No artwork IDs found.")
            return
        }

        let start = artworks.count
        let end = min(start + batchSize, ids.count)

        do {
            for i in start..<end {
                let objectID = ids[i]
                let artwork = try await NetworkService.shared.request(
                    endpoint: MetMuseumAPI.artworkDetails(objectID: "\(objectID)"),
                    responseType: Artwork.self
                )
                artworks.append(artwork)
            }
            viewState = .normal(artworks)
        } catch {
            viewState = .error("Failed to load artwork details: \(error.localizedDescription)")
        }
    }
}

