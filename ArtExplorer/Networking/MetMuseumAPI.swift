//
//  MetMuseumAPI.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 09/06/25.
//

import Foundation

enum MetMuseumAPI: Endpoint {
    case searchArtworks(query: String)
    case artworkDetails(objectID: String)

    private static let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"

    var url: URL {
        switch self {
        case .searchArtworks(let query):
            var components = URLComponents(string: "\(Self.baseURL)/search")!
            components.queryItems = [
                URLQueryItem(name: "hasImages", value: "true"),
                URLQueryItem(name: "q", value: query)
            ]
            return components.url!
        case .artworkDetails(let objectID):
            return URL(string: "\(Self.baseURL)/objects/\(objectID)")!
        }
    }
}
