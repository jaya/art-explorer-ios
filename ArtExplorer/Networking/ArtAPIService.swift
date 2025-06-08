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

    func fetchArtworks() async throws -> [ArtworkData] {
        let url = URL(string: "https://api.artic.edu/api/v1/artworks")!
        let (data, _) = try await URLSession.shared.data(from: url)

        let response = try JSONDecoder().decode(ArtworksResponse.self, from: data)
        return response.data
    }
}
