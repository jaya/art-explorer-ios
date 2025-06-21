//
//  Networking.swift
//  art-explorer
//
//  Created by Pedro Freddi on 17/06/25.
//

import Foundation
import OSLog

struct HTTPMethod: RawRepresentable {
    static let GET = HTTPMethod(rawValue: "GET")

    let rawValue: String
}

struct Encoder {
    static func JSONParameters(_ parameters: Networking.Parameters?) -> Data? {
        guard let parameters = parameters else { return nil }
        do {
            return try JSONSerialization.data(withJSONObject: parameters)
        } catch _ {
            return nil
        }
    }
}

protocol Networking {
    associatedtype APIResponse: Decodable
    typealias Parameters = [String: Any]

    var url: String { get set }
    var method: HTTPMethod? { get set }
    var parameters: Parameters? { get set }
    var session: URLSession { get }

    func request() async throws -> APIResponse
    func downloadFile() async throws -> URL
}

extension Networking {
    var session: URLSession { URLSession.shared }

    func request() async throws -> APIResponse {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = method?.rawValue
        request.httpBody = Encoder.JSONParameters(parameters)

        do {
            let (data, response) = try await session.data(for: request)
            let decoder = JSONDecoder()
            let convertedResponse = try decoder.decode(APIResponse.self, from: data)
            Logger.network.error("\(url)")
            return convertedResponse
        } catch let error {
            Logger.network.error("\(url): \(error)")
            throw error
        }
    }

    func downloadFile() async throws -> URL {
        guard let url = URL(string: url) else { throw URLError(.badURL) }

        let (localUrl, _) = try await session.download(from: url)
        Logger.network.info("🌐 Downloaded File from url: \(url) \n\n Local url: \(localUrl)")
        return localUrl
    }
}
