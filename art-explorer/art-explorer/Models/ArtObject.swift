//
//  ArtObject.swift
//  art-explorer
//
//  Created by Pedro Freddi on 17/06/25.
//

import Foundation

struct GetArtIdsResponse: Codable {
    let total: Int
    let objectIDs: [Int]
}

struct ArtObject: Codable {
    let objectID: Int
    let isHighlight: Bool
    let accessionNumber: String
    let accessionYear: String
    let isPublicDomain: Bool
    let primaryImage: String
    let primaryImageSmall: String
    let additionalImages: [String]
    let constituents: [Constituent]?
    let department: String
    let objectName: String
    let title: String
    let culture: String
    let period: String
    let dynasty: String
    let reign: String
    let portfolio: String
    let artistRole: String
    let artistPrefix: String
    let artistDisplayName: String
    let artistDisplayBio: String
    let artistSuffix: String
    let artistAlphaSort: String
    let artistNationality: String
    let artistBeginDate: String
    let artistEndDate: String
    let artistGender: String
    let artistWikidataURL: String
    let artistULANURL: String
    let objectDate: String
    let objectBeginDate: Int
    let objectEndDate: Int
    let medium: String
    let dimensions: String
    let measurements: [Measurement]?
    let creditLine: String
    let geographyType: String
    let city: String
    let state: String
    let county: String
    let country: String
    let region: String
    let subregion: String
    let locale: String
    let locus: String
    let excavation: String
    let river: String
    let classification: String
    let rightsAndReproduction: String
    let linkResource: String
    let metadataDate: String
    let repository: String
    let objectURL: String
    let tags: [Tag]?
    let objectWikidataURL: String
    let isTimelineWork: Bool
    let galleryNumber: String

    enum CodingKeys: String, CodingKey {
        case objectID, isHighlight, accessionNumber, accessionYear, isPublicDomain
        case primaryImage, primaryImageSmall, additionalImages, constituents, department
        case objectName, title, culture, period, dynasty, reign, portfolio, artistRole
        case artistPrefix, artistDisplayName, artistDisplayBio, artistSuffix, artistAlphaSort
        case artistNationality, artistBeginDate, artistEndDate, artistGender
        case artistWikidataURL = "artistWikidata_URL"
        case artistULANURL = "artistULAN_URL"
        case objectDate, objectBeginDate, objectEndDate, medium, dimensions, measurements
        case creditLine, geographyType, city, state, county, country, region, subregion
        case locale, locus, excavation, river, classification, rightsAndReproduction
        case linkResource, metadataDate, repository, objectURL, tags
        case objectWikidataURL = "objectWikidata_URL"
        case isTimelineWork, galleryNumber = "GalleryNumber"
    }
}

struct Constituent: Codable {
    let constituentID: Int
    let role: String
    let name: String
    let constituentULANURL: String
    let constituentWikidataURL: String
    let gender: String

    enum CodingKeys: String, CodingKey {
        case constituentID, role, name
        case constituentULANURL = "constituentULAN_URL"
        case constituentWikidataURL = "constituentWikidata_URL"
        case gender
    }
}

struct Measurement: Codable {
    let elementName: String
    let elementDescription: String?
    let elementMeasurements: [String: Double]
}

struct Tag: Codable {
    let term: String
    let aatUrl: String?
    let wikidataUrl: String?

    enum CodingKeys: String, CodingKey {
        case term
        case aatUrl = "AAT_URL"
        case wikidataUrl = "Wikidata_URL"
    }
}

extension ArtObject {
    static let fixtures: [ArtObject] = (1...15).map { index in
        ArtObject(
            objectID: index,
            isHighlight: index % 2 == 0,
            accessionNumber: "\(10000 + index).A",
            accessionYear: "18\(index)",
            isPublicDomain: index % 3 == 0,
            primaryImage: "https://example.com/image\(index).jpg",
            primaryImageSmall: "https://example.com/image\(index)_small.jpg",
            additionalImages: [],
            constituents: [
                Constituent(
                    constituentID: index,
                    role: "Artist",
                    name: "Artist \(index)",
                    constituentULANURL: "http://ulan.example.com/\(index)",
                    constituentWikidataURL: "http://wikidata.example.com/Q\(index)",
                    gender: index % 2 == 0 ? "Male" : "Female"
                )
            ],
            department: "Paintings",
            objectName: "Object \(index)",
            title: "Title \(index)",
            culture: "CultureX",
            period: "PeriodX",
            dynasty: "DynastyX",
            reign: "ReignX",
            portfolio: "PortfolioX",
            artistRole: "Painter",
            artistPrefix: "",
            artistDisplayName: "Display Name \(index)",
            artistDisplayBio: "Bio of Artist \(index)",
            artistSuffix: "",
            artistAlphaSort: "AlphaSort \(index)",
            artistNationality: "NationalityX",
            artistBeginDate: "15\(index)",
            artistEndDate: "17\(index)",
            artistGender: index % 2 == 0 ? "Male" : "Female",
            artistWikidataURL: "http://wikidata.org/entity/Q\(index)",
            artistULANURL: "http://ulan.org/\(index)",
            objectDate: "16\(index)",
            objectBeginDate: 1400 + index,
            objectEndDate: 1600 + index,
            medium: "Oil on Canvas",
            dimensions: "24 x 36 in.",
            measurements: [
                Measurement(
                    elementName: "Overall",
                    elementDescription: "Including frame",
                    elementMeasurements: [
                        "Height": 60.0,
                        "Width": 90.0
                    ]
                )
            ],
            creditLine: "Gift of John Doe",
            geographyType: "Region",
            city: "New York",
            state: "NY",
            county: "Kings",
            country: "USA",
            region: "North America",
            subregion: "East Coast",
            locale: "Urban",
            locus: "",
            excavation: "",
            river: "",
            classification: "Paintings",
            rightsAndReproduction: "CC0",
            linkResource: "https://metmuseum.org/art/\(index)",
            metadataDate: ISO8601DateFormatter().string(from: Date()),
            repository: "The Met",
            objectURL: "https://metmuseum.org/object/\(index)",
            tags: [
                Tag(
                    term: "Nature",
                    aatUrl: "http://vocab.getty.edu/page/aat/300132294",
                    wikidataUrl: "https://www.wikidata.org/wiki/Q7868"
                )
            ],
            objectWikidataURL: "https://www.wikidata.org/wiki/Q\(index)",
            isTimelineWork: index % 2 == 0,
            galleryNumber: "\(100 + index)"
        )
    }
}
