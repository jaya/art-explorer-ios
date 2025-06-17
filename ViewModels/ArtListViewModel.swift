//
//  ArtListViewModel.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import Foundation

final class ArtListViewModel: ObservableObject {
    @Published private(set) var artworks: [ArtObject] = []
    @Published private(set) var isLoading = false
    @Published var error: String?

    private let service: ArtServiceProtocol
    private let favoritesService: FavoritesServiceProtocol
    private var allIDs: [Int] = []
    private var currentIndex = 0
    private let pageSize = 15

    init(service: ArtServiceProtocol, favoritesService: FavoritesServiceProtocol) {
        self.service = service
        self.favoritesService = favoritesService
    }

    func clearArtworks() {
        self.artworks = []
    }

    func loadInitial() async {
        await MainActor.run {
            isLoading = true
            error = nil
        }

        do {
            let ids = try await service.fetchObjectIDs()

            await MainActor.run {
                allIDs = ids
                currentIndex = 0
                artworks = []
                isLoading = false
            }

            await loadMore()
        } catch {
            await MainActor.run {
                self.error = error.localizedDescription
                isLoading = false
            }
        }
    }

    func loadFavoritesInitial() async {
        await MainActor.run {
            isLoading = true
            error = nil
        }

        let ids = favoritesService.getAllFavorites()

        // mesmo reset
        await MainActor.run {
            allIDs = ids
            currentIndex = 0
            artworks = []
            isLoading = false
        }

        await loadMore()
    }

    private func setIDsAndReset(_ ids: [Int]) async {
        await MainActor.run {
            self.allIDs = ids
            self.currentIndex = 0
            self.artworks = []
        }

        await loadMore()
    }

    func loadMore() async {
        guard await canLoadMore() else { return }

        await MainActor.run {
            self.isLoading = true
        }

        defer {
            Task { @MainActor in self.isLoading = false }
        }

        let endIndex = min(currentIndex + pageSize, allIDs.count)
        let nextIDs = allIDs[currentIndex..<endIndex]

        var loadedObjects: [ArtObject] = []

        await withTaskGroup(of: ArtObject?.self) { group in
            for id in nextIDs {
                group.addTask {
                    try? await self.service.fetchArtObject(id: id)
                }
            }

            for await result in group {
                if let object = result {
                    loadedObjects.append(object)
                }
            }
        }
        
        loadedObjects.sort { $0.id < $1.id }

        await MainActor.run {
            self.artworks.append(contentsOf: loadedObjects)
            self.currentIndex += nextIDs.count
        }
    }

    private func resetError() async {
        await MainActor.run {
            self.error = nil
        }
    }

    private func canLoadMore() async -> Bool {
        await MainActor.run {
            !self.isLoading && self.currentIndex < self.allIDs.count
        }
    }
}
