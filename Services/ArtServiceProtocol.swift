//
//  ArtServiceProtocol.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import Foundation

protocol ArtServiceProtocol {
    func fetchObjectIDs() async throws -> [Int]
    func fetchArtObject(id: Int) async throws -> ArtObject
}
