//
//  Endpoint.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 09/06/25.
//

import Foundation

protocol Endpoint {
    var url: URL { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var method: String { "GET" }
    var headers: [String: String]? { nil }
    var body: Data? { nil }
}
