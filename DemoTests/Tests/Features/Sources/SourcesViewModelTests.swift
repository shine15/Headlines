// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

@MainActor
final class SourcesViewModelTests: XCTestCase {
    private var viewModel: SourcesViewModel!
    private var mockAPIService: NewsAPIServiceStub!
    private var mockSourcesManager: MockSourcesManager!

    override func setUp() {
        super.setUp()

        // Initialize mock API service and sources manager
        mockAPIService = NewsAPIServiceStub()
        mockSourcesManager = MockSourcesManager()

        // Initialize the ViewModel with the mock dependencies
        viewModel = SourcesViewModel(apiService: mockAPIService, sourcesManager: mockSourcesManager)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        mockSourcesManager = nil
        super.tearDown()
    }

    // Test that `fetchAllSources` successfully fetches sources
    func test_sourcesViewModel_fetchAllSources_success() async {
        // When: Call the `fetchAllSources` method
        await viewModel.fetchAllSources()

        // Then: The sources array should be populated correctly
        XCTAssertEqual(
            viewModel.sources.count,
            3,
            "The sources array should contain the correct number of sources."
        )
        XCTAssertEqual(viewModel.sources.first?.id, "abc-news", "The first source should be ABC News.")
        XCTAssertEqual(viewModel.sources.last?.id, "cnn", "The last source should be CNN.")
    }

    // Test that `isSelected` correctly returns true when the source is selected
    func test_sourcesViewModel_isSelected_true() {
        // Given: Set the selected source ID in the view model
        viewModel.updateSelectedSource(sourceID: "abc-news")

        // When: Check if the source is selected
        let source = Source(
            id: "abc-news",
            name: "ABC News",
            description: "Breaking news",
            url: "https://abcnews.com",
            category: "general",
            language: "en",
            country: "us"
        )
        let result = viewModel.isSelected(source: source)

        // Then: The source should be marked as selected
        XCTAssertTrue(result, "The source should be marked as selected.")
    }

    // Test that `isSelected` correctly returns false when the source is not selected
    func test_sourcesViewModel_isSelected_false() {
        // Given: Set the selected source ID in the view model
        viewModel.updateSelectedSource(sourceID: "bbc-news")

        // When: Check if the source is selected
        let source = Source(
            id: "abc-news",
            name: "ABC News",
            description: "Breaking news",
            url: "https://abcnews.com",
            category: "general",
            language: "en",
            country: "us"
        )
        let result = viewModel.isSelected(source: source)

        // Then: The source should not be selected
        XCTAssertFalse(result, "The source should not be marked as selected.")
    }

    // Test that `updateSelectedSource` updates the selected source ID in both the view model and the sources
    // manager
    func test_sourcesViewModel_updateSelectedSource() {
        // Given: Set the initial selected source ID in the view model
        viewModel.updateSelectedSource(sourceID: "abc-news")
        let newSourceID = "bbc-news"

        // When: Update the selected source
        viewModel.updateSelectedSource(sourceID: newSourceID)

        // Then: The selected source ID should be updated in the view model
        XCTAssertEqual(viewModel.selectedSourceID, newSourceID, "The selected source ID should be updated.")
        XCTAssertEqual(
            mockSourcesManager.selectedSourceID,
            newSourceID,
            "The sources manager should be updated with the new source ID."
        )
    }
}
