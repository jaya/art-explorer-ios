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
//    @Attribute(.unique) var objectID: String
    var objectID: String
    var title: String
    var artistDisplayName: String
    var objectDate: String
    var medium: String
    var creditLine: String
    var primaryImage: String
    var primaryImageSmall: String
    var isFavorite: Bool

    init(
        objectID: String,
        title: String,
        artistDisplayName: String,
        objectDate: String,
        medium: String,
        creditLine: String,
        primaryImage: String,
        primaryImageSmall: String,
        isFavorite: Bool = false
    ) {
        self.objectID = objectID
        self.title = title
        self.artistDisplayName = artistDisplayName
        self.objectDate = objectDate
        self.medium = medium
        self.creditLine = creditLine
        self.primaryImage = primaryImage
        self.primaryImageSmall = primaryImageSmall
        self.isFavorite = isFavorite
    }
}
