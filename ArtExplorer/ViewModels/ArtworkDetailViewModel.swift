//
//  ArtworkDetailViewModel.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 08/06/25.
//

import Foundation
import SwiftData

import Foundation
import SwiftData

@MainActor
class ArtworkDetailViewModel: ObservableObject {
    @Published var artwork: Artwork
    private let context: ModelContext

    init(artwork: Artwork, context: ModelContext) {
        self.artwork = artwork
        self.context = context
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
                } else {
                    let model = artwork.toArtworkModel()
                    context.insert(model)
                }

                try context.save()
            } catch {
                print("Error on saving favorites: \(error)")
            }
        }
    }

    func isFavorited() async -> Bool {
        do {
            let descriptor = FetchDescriptor<ArtworkModel>(
                predicate: #Predicate { $0.id == artwork.id }
            )
            return try context.fetchCount(descriptor) > 0
        } catch {
            return false
        }
    }
}
