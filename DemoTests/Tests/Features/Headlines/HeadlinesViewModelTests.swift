// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

@MainActor
final class HeadlinesViewModelTests: XCTestCase {
    private var viewModel: HeadlinesViewModel!
    private var apiServiceStub: NewsAPIServiceStub!
    private var sourcesManager: MockSourcesManager!

    override func setUp() {
        super.setUp()

        // Setup the stubbed API service and mock sources manager
        apiServiceStub = NewsAPIServiceStub()
        sourcesManager = MockSourcesManager()

        // Create the ViewModel instance using the mock services
        viewModel = HeadlinesViewModel(apiService: apiServiceStub, sourcesManager: sourcesManager)
    }

    override func tearDown() {
        viewModel = nil
        apiServiceStub = nil
        sourcesManager = nil
        super.tearDown()
    }

    // Test the default state of the ViewModel
    func test_headlinesViewModel_initialState() {
        XCTAssertEqual(viewModel.headlinesTabTitle, "News", "The headlines tab title should be 'News'.")
        XCTAssertEqual(
            viewModel.headlinesTabIcon,
            "newspaper",
            "The headlines tab icon should be 'newspaper'."
        )
        XCTAssertEqual(
            viewModel.navigationTitle,
            "Top Stories",
            "The navigation title should be 'Top Stories'."
        )
        XCTAssertEqual(
            viewModel.errorMessage,
            "Something went wrong while fetching the latest news. Please try again later.",
            "The error message should be as expected."
        )

        XCTAssertTrue(viewModel.headlines.isEmpty, "The headlines list should be empty initially.")
        XCTAssertFalse(viewModel.showNetworkError, "Network error should not be shown initially.")
        XCTAssertTrue(viewModel.showLoadingProgress, "Loading progress should be shown initially.")
    }

    // Test successful fetching of headlines
    func test_headlinesViewModel_fetchHeadlines_success() async {
        // Given: Set up the selected source to "abc-news"
        sourcesManager.setSelectedSourceID("abc-news")

        // When: Call the fetchHeadlines method
        await viewModel.fetchHeadlines()

        // Then: Ensure that headlines are populated correctly
        XCTAssertEqual(viewModel.headlines.count, 2, "There should be 2 articles returned.")
        XCTAssertEqual(
            viewModel.headlines.first?.title,
            "ABC News: Breaking News Today",
            "The first article title should match the expected title."
        )
        XCTAssertEqual(
            viewModel.headlines.last?.title,
            "ABC Update: Politics",
            "The second article title should match the expected title."
        )

        // Assert: Ensure the loading state is correctly updated
        XCTAssertFalse(
            viewModel.showLoadingProgress,
            "Loading progress should be hidden after fetching headlines."
        )
        XCTAssertFalse(
            viewModel.showNetworkError,
            "Network error should not be shown after successful fetch."
        )
    }

    // Test handling errors while fetching headlines
    func test_headlinesViewModel_fetchHeadlines_error() async {
        // Given: Set up the selected source to an invalid source that will throw an error
        sourcesManager.setSelectedSourceID("invalid-source")

        // When: Call the fetchHeadlines method
        await viewModel.fetchHeadlines()

        // Then: Ensure that the network error is displayed
        XCTAssertTrue(viewModel.showNetworkError, "Network error should be shown if the fetch fails.")
        XCTAssertFalse(
            viewModel.showLoadingProgress,
            "Loading progress should be hidden after fetching fails."
        )
    }

    // Test that the loading state is properly managed during fetch
    func test_headlinesViewModel_loadingState() async {
        sourcesManager.setSelectedSourceID("abc-news")

        // Start fetching headlines
        let fetchTask = Task {
            await viewModel.fetchHeadlines()
        }

        // Verify that the loading progress is shown initially
        XCTAssertTrue(
            viewModel.showLoadingProgress,
            "Loading progress should be shown when fetching headlines."
        )

        // Wait for the fetch to complete
        await fetchTask.value

        // Verify that loading progress is hidden after fetching is done
        XCTAssertFalse(
            viewModel.showLoadingProgress,
            "Loading progress should be hidden after fetching headlines."
        )
    }

    // Test that the error message is correct when an error occurs
    func test_headlinesViewModel_errorMessage() async {
        // Given: Set up the selected source to an invalid source
        sourcesManager.setSelectedSourceID("invalid-source")

        // When: Call the fetchHeadlines method
        await viewModel.fetchHeadlines()

        // Then: Ensure that the correct error message is shown
        XCTAssertTrue(viewModel.showNetworkError, "Network error should be shown when fetch fails.")
        XCTAssertEqual(
            viewModel.errorMessage,
            "Something went wrong while fetching the latest news. Please try again later.",
            "The error message should be displayed correctly."
        )
    }
}
