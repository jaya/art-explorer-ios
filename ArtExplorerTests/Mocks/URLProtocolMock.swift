//
//  URLProtocolMock.swift
//  ArtExplorer
//
//  Created by Thalisson Melo on 16/06/25.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    static var testData: Data?
    static var testResponse: URLResponse?
    static var testError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = URLProtocolMock.testError {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            let response = URLProtocolMock.testResponse ?? HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = URLProtocolMock.testData {
                client?.urlProtocol(self, didLoad: data)
            }

            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}
