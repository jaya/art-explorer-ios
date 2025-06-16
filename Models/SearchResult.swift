//
//  SearchResult.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import Foundation

struct SearchResult: Decodable {
    let total: Int
    let objectIDs: [Int]?
}
