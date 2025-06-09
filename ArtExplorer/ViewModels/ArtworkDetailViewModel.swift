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
    @Published private(set) var isFavorite: Bool = false

    private let context: ModelContext

    init(artwork: Artwork, context: ModelContext) {
        self.artwork = artwork
        self.context = context

        Task {
            await checkIfFavorited()
        }
    }

    func toggleFavorite() {
        Task {
            do {
                let descriptor = FetchDescriptor<ArtworkModel>(
                    predicate: #Predicate { $0.id == artwork.id }
                )

                let existing = try context.fetch(descriptor).first

                if let model = existing {
                    context.delete(model)
                    isFavorite = false
                } else {
                    let model = artwork.toArtworkModel()
                    context.insert(model)
                    isFavorite = true
                }

                try context.save()
            } catch {
                print("Error on saving favorites: \(error)")
            }
        }
    }

    func checkIfFavorited() async {
        do {
            let descriptor = FetchDescriptor<ArtworkModel>(
                predicate: #Predicate { $0.id == artwork.id }
            )
            let count = try context.fetchCount(descriptor)
            isFavorite = count > 0
        } catch {
            isFavorite = false
        }
    }
}

