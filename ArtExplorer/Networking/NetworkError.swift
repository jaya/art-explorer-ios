//
//  NetworkError.swift
//  ArtExplorer
//
//  Created by Rafael Almeida on 09/06/25.
//

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
}
