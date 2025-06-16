//
//  ArtDetailViewModel.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import Foundation
import Combine

final class ArtDetailViewModel: ObservableObject {
    @Published private(set) var isFavorite: Bool = false
    let art: ArtObject

    private let service: FavoritesServiceProtocol
    
    init(art: ArtObject, service: FavoritesServiceProtocol) {
        self.art = art
        self.service = service
        self.isFavorite = service.isFavorite(art.id)
    }

    func toggleFavorite() {
        service.toggleFavorite(art.id)
        isFavorite.toggle()
    }
}
