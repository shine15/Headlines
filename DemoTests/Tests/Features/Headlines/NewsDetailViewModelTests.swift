// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

@MainActor
class NewsDetailViewModelTests: XCTestCase {
    private var viewModel: NewsDetailViewModel!
    private var mockLocalStorage: MockLocalStorage!

    private let article = Article(
        source: Source(
            id: "abc-news",
            name: "ABC News",
            description: "Breaking news from ABC",
            url: "https://abcnews.com/article1",
            category: "general",
            language: "en",
            country: "us"
        ),
        author: "Author1",
        title: "ABC News: Breaking News Today",
        description: "An update on the latest breaking news from ABC News.",
        url: "https://abcnews.com/article1",
        urlToImage: "https://abcnews.com/article1.jpg",
        publishedAt: Calendar.current.date(byAdding: .hour, value: -2, to: Date())!,
        content: "Full article content here..."
    )

    override func setUp() {
        super.setUp()
        mockLocalStorage = MockLocalStorage()
        viewModel = NewsDetailViewModel(article: article, localStorage: mockLocalStorage)
    }

    override func tearDown() {
        viewModel = nil
        mockLocalStorage = nil
        super.tearDown()
    }

    // Test that the `isSaved` property is correctly initialized
    func test_newsDetailViewModel_initialState() {
        XCTAssertFalse(viewModel.isSaved, "The article should not be saved initially.")
    }

    // Test the `toggleSaved` method when the article is not saved yet
    func test_newsDetailViewModel_toggleSaved_whenNotSaved() {
        // When: Toggle the saved state (the article should be saved now)
        viewModel.toggleSaved()

        // Then: The article is saved, and the `isSaved` state is true
        XCTAssertTrue(viewModel.isSaved, "The article should be marked as saved.")
        XCTAssertTrue(
            mockLocalStorage.allBookmarksURL.contains(article.url ?? ""),
            "The article should be saved in local storage."
        )
    }

    // Test the `toggleSaved` method when the article is already saved
    func test_newsDetailViewModel_toggleSaved_whenAlreadySaved() {
        // Given: Save the article initially
        mockLocalStorage.saveBookmark(article: article)
        viewModel.checkSaved()

        // When: Toggle the saved state (the article should be removed now)
        viewModel.toggleSaved()

        // Then: The article is removed, and the `isSaved` state is false
        XCTAssertFalse(viewModel.isSaved, "The article should be removed from saved state.")
        XCTAssertFalse(
            mockLocalStorage.allBookmarksURL.contains(article.url ?? ""),
            "The article should be removed from local storage."
        )
    }

    // Test the `checkSaved` method to check if the article is saved initially
    func test_newsDetailViewModel_checkSaved_whenNotSaved() {
        // When: Call the checkSaved method (it should check local storage for the article)
        viewModel.checkSaved()

        // Then: The article should not be marked as saved initially
        XCTAssertFalse(
            viewModel.isSaved,
            "The article should not be marked as saved when it's not saved in local storage."
        )
    }

    // Test the `checkSaved` method to check if the article is saved after it's been saved
    func test_newsDetailViewModel_checkSaved_whenSaved() {
        // Given: Save the article initially
        mockLocalStorage.saveBookmark(article: article)

        // When: Call the checkSaved method (it should check local storage for the article)
        viewModel.checkSaved()

        // Then: The article should be marked as saved
        XCTAssertTrue(
            viewModel.isSaved,
            "The article should be marked as saved after it's saved in local storage."
        )
    }
}
