// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import Foundation

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        guard let data, let response else {
            throw NetworkError.unknown
        }
        return (data, response)
    }
}
