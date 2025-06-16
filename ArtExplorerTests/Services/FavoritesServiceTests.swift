//
//  FavoriteService.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//


import XCTest
@testable import ArtExplorer

final class FavoritesServiceTests: XCTestCase {
    var service: FavoritesServiceProtocol!
    let testKey = "favorite_ids"
    var testDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        testDefaults = UserDefaults(suiteName: "test_suite")!
        testDefaults.removePersistentDomain(forName: "test_suite")
        service = FavoritesService(defaults: testDefaults)
    }

    override func tearDown() {
        testDefaults.removePersistentDomain(forName: "test_suite")
        service = nil
        super.tearDown()
    }

    func testToggleFavoriteAddsAndRemoves() {
        XCTAssertFalse(service.isFavorite(101))
        
        service.toggleFavorite(101)
        XCTAssertTrue(service.isFavorite(101))
        
        service.toggleFavorite(101)
        XCTAssertFalse(service.isFavorite(101))
    }

    func testGetAllFavoritesReturnsCorrectIDs() {
        service.toggleFavorite(10)
        service.toggleFavorite(20)
        service.toggleFavorite(30)

        let favorites = service.getAllFavorites()
        XCTAssertTrue(favorites.contains(10))
        XCTAssertTrue(favorites.contains(20))
        XCTAssertTrue(favorites.contains(30))
        XCTAssertEqual(favorites.count, 3)
    }
}
