//
//  ArtServiceMock.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import Foundation
@testable import ArtExplorer

final class ArtServiceMock: ArtServiceProtocol {
    var objectIDsToReturn: [Int] = []
    var artObjectsToReturn: [Int: ArtObject] = [:]
    var shouldThrow = false

    func fetchObjectIDs() async throws -> [Int] {
        if shouldThrow { throw NSError(domain: "", code: 1, userInfo: nil) }
        return objectIDsToReturn
    }

    func fetchArtObject(id: Int) async throws -> ArtObject {
        if shouldThrow {
            throw NSError(domain: "", code: 2, userInfo: nil)
        }
        guard let object = artObjectsToReturn[id] else {
            throw NSError(domain: "ArtServiceMock", code: 404, userInfo: [NSLocalizedDescriptionKey: "ArtObject \(id) não encontrado no mock"])
        }
        return object
    }
}
