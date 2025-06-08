//
//  ArtworkCollection.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation

struct ArtworkCollection: Decodable {
    let total: Int
    let objectIDs: [Int]?
}
