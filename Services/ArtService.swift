//
//  ArtService.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 15/06/25.
//

import Foundation

final class ArtService: ArtServiceProtocol {
    private let baseURL = "https://collectionapi.metmuseum.org/public/collection/v1"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchObjectIDs() async throws -> [Int] {
        
        if CommandLine.arguments.contains("--uitesting-error") {
            throw NSError(domain: "UITest", code: 999, userInfo: [NSLocalizedDescriptionKey: "Erro simulado"])
        }
        
        let url = URL(string: "\(baseURL)/search?hasImages=true&q=painting")!
        let (data, _) = try await session.data(from: url)
        let result = try JSONDecoder().decode(SearchResult.self, from: data)
        return result.objectIDs ?? []
    }
    
    func fetchArtObject(id: Int) async throws -> ArtObject {
        let url = URL(string: "\(baseURL)/objects/\(id)")!
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode(ArtObject.self, from: data)
    }
}
