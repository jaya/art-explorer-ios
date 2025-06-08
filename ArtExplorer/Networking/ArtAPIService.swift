//
//  ArtAPIService.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation

final class ArtAPIService {
    static let shared = ArtAPIService()
    private init() {}

    func fetchArtworks() async throws -> ArtworkCollection {
        let url = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&q=painting")!
        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(ArtworkCollection.self, from: data)
    }

    func fetchArtworksDetails(objectID: String) async throws -> Artwork {
        let url = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(objectID)")!
        let (data, _) = try await URLSession.shared.data(from: url)

        return try JSONDecoder().decode(Artwork.self, from: data)
    }
}
