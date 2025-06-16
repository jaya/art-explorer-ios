//
//  FavoritesService.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import Foundation

final class FavoritesService: FavoritesServiceProtocol {
    private let key = "favorite_ids"
    private let defaults: UserDefaults

    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }

    func isFavorite(_ id: Int) -> Bool {
        getAllFavorites().contains(id)
    }

    func toggleFavorite(_ id: Int) {
        var current = getAllFavorites()

        if let index = current.firstIndex(of: id) {
            current.remove(at: index)
        } else {
            current.append(id)
        }

        defaults.set(current, forKey: key)
    }

    func getAllFavorites() -> [Int] {
        defaults.array(forKey: key) as? [Int] ?? []
    }
}
