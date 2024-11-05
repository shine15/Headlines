// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

protocol NetworkManagerProtocol {
    func request<Response>(
        _ type: Response.Type,
        request: URLRequest
    ) async throws -> Response where Response: Decodable
}

enum NetworkError: Error {
    case invalidURL(url: String)
    case invalidHTTPURLResponse
    case invalidStatusCode(code: Int, data: Data)
    case decodingError(reason: String)
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .invalidURL(url):
            "The URL provided is invalid: \(url)"
        case .invalidHTTPURLResponse:
            "The server response was not a valid HTTP URL response."
        case .invalidStatusCode:
            "The status code returned by the server indicates an error."
        case .decodingError:
            "JSON decoding error"
        case .unknown:
            "An unknown error occurred"
        }
    }

    var failureReason: String? {
        switch self {
        case .invalidURL:
            return "The URL format was incorrect or could not be processed."
        case .invalidHTTPURLResponse:
            return "The response from the server did not meet HTTP standards."
        case let .invalidStatusCode(code, data):
            let dataString = String(data: data, encoding: .utf8) ?? "No response body"
            return "The server returned an invalid status code: \(code). Response data: \(dataString)"
        case let .decodingError(reason):
            return "There was an issue decoding the data: \(reason)"
        case .unknown:
            return "An unknown error occurred"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidURL:
            "Please check the URL and try again."
        case .invalidHTTPURLResponse:
            "Try reloading the request or check your network connection."
        case .invalidStatusCode:
            "Review the server response for further details or contact support."
        case .decodingError:
            "Review JSON structure & data model"
        case .unknown:
            "An unknown error occurred"
        }
    }
}

final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSessionProtocol
    private let logger: LoggerProtocol

    init(session: URLSessionProtocol, logger: LoggerProtocol) {
        self.session = session
        self.logger = logger
    }

    func request<Response>(
        _: Response.Type,
        request: URLRequest
    ) async throws -> Response where Response: Decodable {
        logRequest(request)

        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidHTTPURLResponse
            }

            logResponse(httpResponse, data: data)

            guard (200 ... 299).contains(httpResponse.statusCode) else {
                let error = NetworkError.invalidStatusCode(code: httpResponse.statusCode, data: data)
                throw error
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                return try decoder.decode(Response.self, from: data)
            } catch let decodingError as DecodingError {
                let detailedError = parseDecodingError(decodingError)
                throw NetworkError.decodingError(reason: detailedError)
            } catch {
                throw error
            }
        } catch {
            logError(error)
            throw error
        }
    }
}

// MARK: - Logging

extension NetworkManager {
    private func logRequest(_ request: URLRequest) {
        guard let method = request.httpMethod, let url = request.url else {
            logger.debug("Invalid request: Missing HTTP method or URL.")
            return
        }

        logger.debug("Request: [\(method)] \(url.absoluteString)")

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            logger.debug("Request Headers: \(headers)")
        } else {
            logger.debug("Request Headers: None")
        }

        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            logger.debug("Request Body: \(bodyString)")
        } else {
            logger.debug("Request Body: None")
        }
    }

    private func logResponse(_ response: HTTPURLResponse, data: Data) {
        logger.debug("Response Status Code: \(response.statusCode)")
        if let responseBody = String(data: data, encoding: .utf8), !responseBody.isEmpty {
            logger.debug("Response Body: \(responseBody)")
        } else {
            logger.debug("Response Body: Empty")
        }
    }

    private func logError(_ error: Error) {
        logger.error("Response Error: \(error.localizedDescription)")
        if let localizedError = error as? LocalizedError, let failureReason = localizedError.failureReason {
            logger.error("Failure Reason: \(failureReason)")
        }
    }

    private func parseDecodingError(_ error: DecodingError) -> String {
        switch error {
        case let .typeMismatch(type, context):
            return "Type mismatch for type \(type) at \(context.codingPath.map(\.stringValue).joined(separator: ".")): \(context.debugDescription)"
        case let .valueNotFound(type, context):
            return "Value not found for type \(type) at \(context.codingPath.map(\.stringValue).joined(separator: ".")): \(context.debugDescription)"
        case let .keyNotFound(key, context):
            return "Key '\(key.stringValue)' not found at \(context.codingPath.map(\.stringValue).joined(separator: ".")): \(context.debugDescription)"
        case let .dataCorrupted(context):
            return "Data corrupted at \(context.codingPath.map(\.stringValue).joined(separator: ".")): \(context.debugDescription)"
        @unknown default:
            return "Unknown decoding error: \(error.localizedDescription)"
        }
    }
}
