//
//  ArtObjectRepository.swift
//  art-explorer
//
//  Created by Pedro Freddi on 16/06/25.
//

import Foundation
import OSLog
import UIKit
import CoreData

protocol ArtObjectRepository {
//    var pages: [[Int]] { get }
//    var currentPage: Int { get set }
//    var artObjects: [ArtObject] { get set }
    func fetchArtObjects() async throws
    func fetchArtIds() async throws
    func fetchArtDetails(_ id: Int) async throws -> ArtObject
    func fetchDepartments() async throws
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

enum ArtObjectRepositoryError: LocalizedError {
    case fetchError

    var errorDescription: String? {
        switch self {
        case .fetchError:
            return "Something went wrong while connecting to the server. Try again later."
        }
    }
}

final class ArtRepository: ArtObjectRepository {
    @Published var pages: [[Int]] = []
    @Published var artObjects: [ArtObject] = []
    @Published var favoriteIds: Set<Int> = []
    @Published var favorites: [ArtObject] = []
    @Published var artIds: [Int] = []
    @Published var departments: [Department] = []
    internal var currentPage: Int = -1
    internal let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    internal let request: NSFetchRequest<FavoriteArt> = FavoriteArt.fetchRequest()

    init() {
        do {
            let favorites = try context.fetch(request)
            favoriteIds = Set(favorites.map { Int($0.id) })
        } catch {
            Logger.database.error("Error loading favorites: \(error)")
        }
    }

    func fetchArtObjects() async throws {
        do {
            if pages.isEmpty {
                try await fetchArtIds()
            }
            currentPage += 1
            if currentPage < pages.count {
                let pageItems = pages[currentPage]
                var arts = [ArtObject]()
                for pageItem in pageItems {
                    let artObject = try await fetchArtDetails(pageItem)
                    arts.append(artObject)
                }
                artObjects += arts
            }
        } catch {
            throw ArtObjectRepositoryError.fetchError
        }
    }

    func fetchArtIds() async throws {
        let data = try await GetArtIdsRequest().request()
        pages = data.objectIDs.chunked(into: 15)
    }

    func fetchArtDetails(_ id: Int) async throws -> ArtObject {
        do {
            return try await GetArtDetailsByIdRequest(id).request()
        } catch {
            throw ArtObjectRepositoryError.fetchError
        }
    }

    func fetchDepartments() async throws {
    }

    func getArtById(_ id: Int) -> ArtObject? {
        return artObjects.first { $0.objectID == id }
    }

    func getFavorites() async {
        var favorites: [ArtObject] = []
        for artId in favoriteIds {
            if let artObject = getArtById(artId) {
                favorites.append(artObject)
            } else {
                do {
                    let art = try await fetchArtDetails(artId)
                    favorites.append(art)
                } catch {
                    // TBD
                }
            }
        }
        self.favorites = favorites
    }

    func isArtFavorite(_ id: Int) -> Bool {
        return favoriteIds.contains(id)
    }

    func addFavorite(artId: Int) {
        let newFavorite = FavoriteArt(context: context)
        newFavorite.id = Int64(artId)
        do {
            try context.save()
            Logger.database.info("Succesfully added new favorite: \(artId)")
            favoriteIds.insert(artId)
            if let art = getArtById(artId) {
                favorites.append(art)
            }
        } catch {
            Logger.database.error("Error adding new favorite: \(error.localizedDescription)")
        }
    }

    func removeFavorite(artId: Int) {
        var request = self.request
        request.predicate = NSPredicate(format: "id == %d", artId)
        do {
            if let favoriteToDelete = try self.context.fetch(request).first {
                self.context.delete(favoriteToDelete)
                try context.save()
                Logger.database.info("Succesfully removed favorite: \(artId)")
                favoriteIds.remove(artId)
                if let favoriteIndex = favorites.firstIndex(where: { $0.objectID == artId }) {
                    favorites.remove(at: favoriteIndex)
                }
            }
        } catch {
            Logger.database.error("Error removing favorite: \(error.localizedDescription)")
        }
    }
}
