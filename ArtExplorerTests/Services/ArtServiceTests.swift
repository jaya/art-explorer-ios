//
//  ArtServiceTests.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import XCTest
@testable import ArtExplorer

final class ArtServiceTests: XCTestCase {
    var service: ArtService!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)

        service = ArtService(session: session)
        URLProtocolMock.testData = nil
    }

    override func tearDown() {
        service = nil
        super.tearDown()
    }

    func testFetchObjectIDsReturnsIDs() async throws {
        let expectedIDs = [123, 456, 789]
        let mockJSON = """
        {
            "total": 3,
            "objectIDs": \(expectedIDs)
        }
        """
        URLProtocolMock.testData = mockJSON.data(using: .utf8)

        let ids = try await service.fetchObjectIDs()
        XCTAssertEqual(ids, expectedIDs)
    }

    func testFetchArtObjectReturnsCorrectObject() async throws {
        let mockJSON = """
        {
            "objectID": 471,
            "title": "Plaque Portrait of Benjamin Franklin",
            "artistDisplayName": "Jean-Baptiste Nini",
            "artistDisplayBio": "Italian, Urbino 1717–1786 Chaumont-sur-Loire",
            "objectDate": "1776–1883",
            "medium": "Ivory",
            "department": "The American Wing",
            "dimensions": "2 5/8 x 2 in. (6.7 x 5.1 cm)",
            "primaryImage": "https://images.metmuseum.org/CRDImages/ad/original/25592.jpg",
            "repository": "Metropolitan Museum of Art, New York, NY",
            "creditLine": "Gift of William H. Huntington, 1883",
            "country": "France",
            "tags": [
                { "term": "Benjamin Franklin" },
                { "term": "Men" },
                { "term": "Portraits" }
            ],
            "objectURL": "https://www.metmuseum.org/art/collection/search/471",
            "primaryImageSmall": "https://images.metmuseum.org/CRDImages/ad/web-large/25592.jpg"
        }
        """
        URLProtocolMock.testData = mockJSON.data(using: .utf8)
        let object = try await service.fetchArtObject(id: 471)
        XCTAssertEqual(object.id, 471)
        XCTAssertEqual(object.title, "Plaque Portrait of Benjamin Franklin")
        XCTAssertEqual(object.artistDisplayName, "Jean-Baptiste Nini")
    }
}
