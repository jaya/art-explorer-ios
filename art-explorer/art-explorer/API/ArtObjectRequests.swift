//
//  ArtObjectRequests.swift
//  art-explorer
//
//  Created by Pedro Freddi on 17/06/25.
//

import Foundation

struct GetArtIdsRequest: Networking {
    typealias APIResponse = GetArtIdsResponse

    var url: String = "https://collectionapi.metmuseum.org/public/collection/v1/search?hasImages=true&q=painting"

    var method: HTTPMethod? = .GET

    var parameters: Parameters?
}

struct GetArtDetailsByIdRequest: Networking {
    typealias APIResponse = ArtObject

    var url: String

    var method: HTTPMethod? = .GET

    var parameters: Parameters?

    init(_ id: Int) {
        url = "https://collectionapi.metmuseum.org/public/collection/v1/objects/\(id)"
    }
}

struct GetDepartmentsRequest: Networking {
    typealias APIResponse = GetDepartmentsResponse

    var url: String = "https://collectionapi.metmuseum.org/public/collection/v1/departments"

    var method: HTTPMethod? = .GET

    var parameters: Parameters?
}
