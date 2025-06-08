//
//  Artwork.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

struct ArtworksResponse: Codable {
    let pagination: Pagination
    let data: [ArtworkData]
    let config: APIConfig
}

struct Pagination: Codable {
    let total: Int
    let limit: Int
    let offset: Int
    let totalPages: Int?
    let currentPage: Int?
    let nextUrl: String?
}

struct APIConfig: Codable {
    let iiifUrl: String
    let websiteUrl: String?

    private enum CodingKeys: String, CodingKey {
        case iiifUrl = "iiif_url"
        case websiteUrl = "website_url"
    }
}

// Dados de cada obra
struct ArtworkData: Identifiable, Codable {
    let id: Int
    let title: String
    let imageId: String?
    let artistDisplay: String?
    let dateDisplay: String?

    private enum CodingKeys: String, CodingKey {
        case id, title
        case imageId = "image_id"
        case artistDisplay = "artist_display"
        case dateDisplay = "date_display"
    }
}

