//
//  Artwork.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation

struct Artwork: Codable, Identifiable {
    var id: Int { objectID }

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
    let artistWikidataURL: String?
    let artistULANURL: String?
    let objectDate: String
    let objectBeginDate: Int
    let objectEndDate: Int
    let medium: String
    let dimensions: String
    let measurements: [Measurement]?
    let creditLine: String
    let classification: String
    let rightsAndReproduction: String
    let linkResource: String?
    let metadataDate: String
    let repository: String
    let objectURL: String
    let objectWikidataURL: String?
    let isTimelineWork: Bool
    let galleryNumber: String?

    struct Constituent: Codable {
        let constituentID: Int
        let role: String
        let name: String
        let constituentULANURL: String?
        let constituentWikidataURL: String?
        let gender: String
    }

    struct Measurement: Codable {
        let elementName: String
        let elementDescription: String?
        let elementMeasurements: [String: Double]
    }

    enum CodingKeys: String, CodingKey {
        case objectID, isHighlight, accessionNumber, accessionYear, isPublicDomain, primaryImage, primaryImageSmall, additionalImages, constituents, department, objectName, title, culture, period, dynasty, reign, portfolio, artistRole, artistPrefix, artistDisplayName, artistDisplayBio, artistSuffix, artistAlphaSort, artistNationality, artistBeginDate, artistEndDate, artistGender
        case artistWikidataURL = "artistWikidata_URL"
        case artistULANURL = "artistULAN_URL"
        case objectDate, objectBeginDate, objectEndDate, medium, dimensions, measurements, creditLine, classification, rightsAndReproduction, linkResource, metadataDate, repository, objectURL
        case objectWikidataURL = "objectWikidata_URL"
        case isTimelineWork, galleryNumber = "GalleryNumber"
    }
}

extension Artwork {
    func toArtworkModel() -> ArtworkModel {
        ArtworkModel(
            objectID: String(objectID),
            title: title,
            artistDisplayName: artistDisplayName,
            objectDate: objectDate,
            medium: medium,
            creditLine: creditLine,
            primaryImage: primaryImage,
            primaryImageSmall: primaryImageSmall
        )
    }
}
