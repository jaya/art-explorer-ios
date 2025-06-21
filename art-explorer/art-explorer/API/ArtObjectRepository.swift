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
    var pages: [[Int]] { get }
    var currentPage: Int { get set }
    var artObjects: [ArtObject] { get set }
    func fetchArtObjects() async
    func fetchArtIds() async throws
    func getArtDetailsById(_ id: Int) async throws -> ArtObject
    func fetchDepartments() async throws
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

final class ArtRepository: ArtObjectRepository {
    internal var currentPage: Int = -1
    @Published var pages: [[Int]] = []
    @Published var artObjects: [ArtObject] = []
    @Published var favoriteArts: Set<Int> = []
    @Published var departments: [Department] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<FavoriteArt> = FavoriteArt.fetchRequest()

    init() {
        do {
            let favorites = try context.fetch(request)
            favoriteArts = Set(favorites.map { Int($0.id) })
            print("Favs: ", favoriteArts)
        } catch {
            print("Error")
        }
    }

    func fetchArtObjects() async {
        if pages.isEmpty {
            try! await fetchArtIds()
        }
        currentPage += 1
        if currentPage < pages.count {
            let pageItems = pages[currentPage]
            var arts = [ArtObject]()
            for pageItem in pageItems {
                let artObject = try? await getArtDetailsById(pageItem)
                if let artObject = artObject {
                    arts.append(artObject)
                }
            }
            artObjects += arts
        }
//        artObjects += ArtObject.fixtures
    }

    func fetchArtIds() async throws {
        let data = try await GetArtIdsRequest().request()
        pages = data.objectIDs.chunked(into: 15)
    }

    func getArtDetailsById(_ id: Int) async throws -> ArtObject {
        return try await GetArtDetailsByIdRequest(id).request()
    }

    func fetchDepartments() async throws {
        departments = try await GetDepartmentsRequest().request().departments
    }

    func getArtById(_ id: Int) -> ArtObject? {
        return artObjects.first { $0.objectID == id }
    }

    func isArtFavorite(_ id: Int) -> Bool {
        return favoriteArts.contains(id)
    }

    func addFavorite(artId: Int) {
        let newFavorite = FavoriteArt(context: context)
        newFavorite.id = Int64(artId)
        do {
            try context.save()
            Logger.database.info("Succesfully added new favorite: \(artId)")
            favoriteArts.insert(artId)
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
                favoriteArts.remove(artId)
            }
        } catch {
            Logger.database.error("Error removing favorite: \(error.localizedDescription)")
        }
    }
}
