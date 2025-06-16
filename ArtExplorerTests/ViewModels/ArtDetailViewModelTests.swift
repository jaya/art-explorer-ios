//
//  ArtDetailViewModelTests.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import XCTest
@testable import ArtExplorer

@MainActor
final class ArtDetailViewModelTests: XCTestCase {
    var mockFavorites: FavoritesServiceMock!
    var viewModel: ArtDetailViewModel!

    override func setUp() {
        super.setUp()
        mockFavorites = FavoritesServiceMock()
    }

    override func tearDown() {
        viewModel = nil
        mockFavorites = nil
        super.tearDown()
    }

    func testIsFavoriteInitialValueTrue() {
        mockFavorites.favoriteIDsToReturn = [42]
        let art = dummyArtObject(id: 42)
        viewModel = ArtDetailViewModel(art: art, service: mockFavorites)

        XCTAssertTrue(viewModel.isFavorite)
    }

    func testIsFavoriteInitialValueFalse() {
        mockFavorites.favoriteIDsToReturn = []
        let art = dummyArtObject(id: 99)
        viewModel = ArtDetailViewModel(art: art, service: mockFavorites)

        XCTAssertFalse(viewModel.isFavorite)
    }

    func testToggleFavoriteTogglesState() {
        let art = dummyArtObject(id: 7)
        viewModel = ArtDetailViewModel(art: art, service: mockFavorites)

        XCTAssertFalse(viewModel.isFavorite)
        viewModel.toggleFavorite()
        XCTAssertTrue(viewModel.isFavorite)
        viewModel.toggleFavorite()
        XCTAssertFalse(viewModel.isFavorite)
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
