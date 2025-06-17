//
//  ArtObject.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import Foundation

struct ArtObject: Identifiable, Decodable, Equatable {
    let id: Int
    let title: String
    let artistDisplayName: String
    let artistDisplayBio: String
    let objectDate: String
    let medium: String
    let department: String
    let dimensions: String
    let primaryImage: String
    let repository: String
    let creditLine: String
    let country: String
    let tags: [Tag]
    let objectURL: String
    let primaryImageSmall: String

    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case title
        case artistDisplayName
        case artistDisplayBio
        case objectDate
        case medium
        case department
        case dimensions
        case primaryImage
        case repository
        case creditLine
        case country
        case tags
        case objectURL
        case primaryImageSmall
    }
}

struct Tag: Decodable, Equatable {
    let term: String
}
