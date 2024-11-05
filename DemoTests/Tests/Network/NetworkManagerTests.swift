// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

struct TestResponse: Decodable {
    let id: Int
    let name: String
}

final class NetworkManagerTests: XCTestCase {
    private var mockSession: MockURLSession!
    private var mockLogger: MockLogger!
    private var networkManager: NetworkManager!

    private let testURL = URL(string: "https://example.com")!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        mockLogger = MockLogger()
        networkManager = NetworkManager(session: mockSession, logger: mockLogger)
    }

    override func tearDown() {
        mockSession = nil
        mockLogger = nil
        networkManager = nil
        super.tearDown()
    }

    func test_networkManager_validResponse() async throws {
        // Given
        let validData = """
        {
            "id": 1,
            "name": "Test Item"
        }
        """.data(using: .utf8)!
        mockSession.data = validData
        mockSession.response = HTTPURLResponse(
            url: testURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When
        let result: TestResponse = try await networkManager.request(
            TestResponse.self,
            request: URLRequest(url: testURL)
        )

        // Then
        XCTAssertEqual(result.id, 1)
        XCTAssertEqual(result.name, "Test Item")
        XCTAssertTrue(
            mockLogger.loggedMessages
                .contains { $0.contains("Request: [GET] https://example.com") }
        )
        XCTAssertTrue(mockLogger.loggedMessages.contains { $0.contains("Response Status Code: 200") })
    }

    func test_networkManager_invalidStatusCode() async {
        // Given
        mockSession.data = Data()
        mockSession.response = HTTPURLResponse(
            url: testURL,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )

        // When/Then
        do {
            _ = try await networkManager.request(
                TestResponse.self,
                request: URLRequest(url: testURL)
            )
            XCTFail("Expected an error but did not get one")
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual(
                (error as? NetworkError)?.errorDescription,
                "The status code returned by the server indicates an error."
            )
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Request: [GET] https://example.com") }
            )
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Response Status Code: 404") }
            )
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains {
                        $0
                            .contains(
                                "Response Error: The status code returned by the server indicates an error."
                            )
                    }
            )
        }
    }

    func test_networkManager_decodingError() async {
        // Given
        let invalidData = """
        {
            "invalid_field": "Test"
        }
        """.data(using: .utf8)!
        mockSession.data = invalidData
        mockSession.response = HTTPURLResponse(
            url: testURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        // When/Then
        do {
            _ = try await networkManager.request(
                TestResponse.self,
                request: URLRequest(url: testURL)
            )
            XCTFail("Expected a decoding error but did not get one")
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual((error as? NetworkError)?.errorDescription, "JSON decoding error")
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Request: [GET] https://example.com") }
            )
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Response Status Code: 200") }
            )
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Response Error: JSON decoding error") }
            )
        }
    }

    func test_networkManager_unknownError() async {
        // Given
        mockSession.error = NetworkError.unknown

        // When/Then
        do {
            _ = try await networkManager.request(
                TestResponse.self,
                request: URLRequest(url: testURL)
            )
            XCTFail("Expected an unknown error but did not get one")
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Request: [GET] https://example.com") }
            )
            XCTAssertTrue(
                mockLogger.loggedMessages
                    .contains { $0.contains("Response Error: An unknown error occurred") }
            )
        }
    }
}
