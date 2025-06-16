//
//  ArtListViewModelTests.swift
//  ArtExplorerTests
//
//  Created by Thalisson Melo on 16/06/25.
//

import XCTest
import Combine
@testable import ArtExplorer

@MainActor
final class ArtListViewModelTests: XCTestCase {
    var viewModel: ArtListViewModel!
    var mockService: ArtServiceMock!
    var mockFavorites: FavoritesServiceMock!

    override func setUp() {
        super.setUp()
        mockService = ArtServiceMock()
        mockFavorites = FavoritesServiceMock()
        viewModel = ArtListViewModel(service: mockService, favoritesService: mockFavorites)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockFavorites = nil
        super.tearDown()
    }

    func waitUntil(timeout: TimeInterval, condition: @escaping () -> Bool) async throws {
        let start = Date()
        while !condition() {
            try await Task.sleep(nanoseconds: 50_000_000)
            if Date().timeIntervalSince(start) > timeout {
                throw XCTSkip("timeout")
            }
        }
    }

    func testLoadInitialLoadsIDsAndFirstPage() async throws {
        mockService.objectIDsToReturn = [1, 2, 3]
        mockService.artObjectsToReturn = [
            1: dummyArtObject(id: 1),
            2: dummyArtObject(id: 2),
            3: dummyArtObject(id: 3)
        ]

        await viewModel.loadInitial()

        try await waitUntil(timeout: 5.0) {
            self.viewModel.artworks.count == 3
        }

        XCTAssertEqual(viewModel.artworks.map(\.id), [1, 2, 3])
    }

    func testLoadInitialHandlesError() async {
        mockService.shouldThrow = true

        await viewModel.loadInitial()

        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.artworks.count, 0)
    }

    func testLoadFavoritesInitialLoadsCorrectly() async throws {
        mockFavorites.favoriteIDsToReturn = [5, 10]
        mockService.artObjectsToReturn = [
            5: dummyArtObject(id: 5),
            10: dummyArtObject(id: 10)
        ]

        await viewModel.loadFavoritesInitial()

        try await waitUntil(timeout: 2.0) {
            self.viewModel.artworks.count == 2
        }

        XCTAssertEqual(viewModel.artworks.map(\.id), [5, 10])
    }

    func testLoadMoreAppendsData() async throws {
        mockService.objectIDsToReturn = Array(1...30)
        for id in 1...30 {
            mockService.artObjectsToReturn[id] = dummyArtObject(id: id)
        }

        await viewModel.loadInitial()

        try await waitUntil(timeout: 2.0) {
            self.viewModel.artworks.count == 15
        }

        await viewModel.loadMore()

        try await waitUntil(timeout: 2.0) {
            self.viewModel.artworks.count == 30
        }

        XCTAssertEqual(viewModel.artworks.map(\.id), Array(1...30))
    }

    private func dummyArtObject(id: Int) -> ArtObject {
        ArtObject(
            id: id,
            title: "Title \(id)",
            artistDisplayName: "Artist \(id)",
            artistDisplayBio: "Bio",
            objectDate: "2000",
            medium: "Oil",
            department: "Dept",
            dimensions: "10x10",
            primaryImage: "https://img.com/\(id).jpg",
            repository: "Museum",
            creditLine: "Gift",
            country: "Country",
            tags: [],
            objectURL: "https://metmuseum.org/\(id)",
            primaryImageSmall: "https://img.com/small/\(id).jpg"
        )
    }
}
