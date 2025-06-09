//
//  ArtworkDetailViewModel.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation
import SwiftData

@MainActor
class ArtworkDetailViewModel: ObservableObject {
    @Published var artwork: Artwork
//    private var context: ModelContext

    init(artwork: Artwork) {
        self.artwork = artwork
//        self.context = context
    }

    func toggleFavorite() {
//        artwork.isFavorite.toggle()
//
//        if artwork.isFavorite {
//            context.insert(artwork.toArtworkModel())
//        }
//
//        do {
//            try context.save()
//        } catch {
//            print("Erro ao salvar favorito: \(error)")
//        }
    }
}
