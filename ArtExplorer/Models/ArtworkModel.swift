//
//  ArtworkModel.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation
import SwiftData

@Model
class ArtworkModel {
    @Attribute(.unique)
    var id: Int
    var title: String
    var artistDisplayName: String
    var objectDate: String
    var medium: String
    var creditLine: String
    var primaryImage: String
    var primaryImageSmall: String

    init(
        id: Int,
        title: String,
        artistDisplayName: String,
        objectDate: String,
        medium: String,
        creditLine: String,
        primaryImage: String,
        primaryImageSmall: String
    ) {
        self.id = id
        self.title = title
        self.artistDisplayName = artistDisplayName
        self.objectDate = objectDate
        self.medium = medium
        self.creditLine = creditLine
        self.primaryImage = primaryImage
        self.primaryImageSmall = primaryImageSmall
    }
}

extension ArtworkModel {
    func toArtwork() -> Artwork {
        return Artwork(
            objectID: id,
            isHighlight: false,
            accessionNumber: "",
            accessionYear: "",
            isPublicDomain: false,
            primaryImage: primaryImage,
            primaryImageSmall: primaryImageSmall,
            additionalImages: [],
            constituents: nil,
            department: "",
            objectName: "",
            title: title,
            culture: "",
            period: "",
            dynasty: "",
            reign: "",
            portfolio: "",
            artistRole: "",
            artistPrefix: "",
            artistDisplayName: artistDisplayName,
            artistDisplayBio: "",
            artistSuffix: "",
            artistAlphaSort: "",
            artistNationality: "",
            artistBeginDate: "",
            artistEndDate: "",
            artistGender: "",
            artistWikidataURL: nil,
            artistULANURL: nil,
            objectDate: objectDate,
            objectBeginDate: 0,
            objectEndDate: 0,
            medium: medium,
            dimensions: "",
            measurements: nil,
            creditLine: creditLine,
            classification: "",
            rightsAndReproduction: "",
            linkResource: nil,
            metadataDate: "",
            repository: "",
            objectURL: "",
            objectWikidataURL: nil,
            isTimelineWork: false,
            galleryNumber: nil
        )
    }
}
