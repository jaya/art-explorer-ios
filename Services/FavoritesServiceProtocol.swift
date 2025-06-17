//
//  FavoritesServiceProtocol.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import Foundation

protocol FavoritesServiceProtocol {
    func isFavorite(_ id: Int) -> Bool
    func toggleFavorite(_ id: Int)
    func getAllFavorites() -> [Int]
}
