//
//  FavoritesServiceMock.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import Foundation
@testable import ArtExplorer

final class FavoritesServiceMock : FavoritesServiceProtocol {
    var favoriteIDsToReturn: [Int] = []

    func isFavorite(_ id: Int) -> Bool {
        favoriteIDsToReturn.contains(id)
    }

    func toggleFavorite(_ id: Int) {}

    func getAllFavorites() -> [Int] {
        return favoriteIDsToReturn
    }
}
