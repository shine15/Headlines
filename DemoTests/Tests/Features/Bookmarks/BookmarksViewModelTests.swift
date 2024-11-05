// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

@MainActor
final class BookmarksViewModelTests: XCTestCase {
    private var viewModel: BookmarksViewModel!
    private var mockLocalStorage: MockLocalStorage!

    override func setUp() {
        super.setUp()

        // Initialize the mock local storage and the view model
        mockLocalStorage = MockLocalStorage()
        viewModel = BookmarksViewModel(localStorage: mockLocalStorage)
    }

    override func tearDown() {
        viewModel = nil
        mockLocalStorage = nil
        super.tearDown()
    }

    // Test: Initial state of the bookmarks array is empty
    func test_bookmarksViewModel_initialState() {
        XCTAssertTrue(viewModel.bookmarks.isEmpty, "Bookmarks array should be empty initially.")
    }

    // Test: Adding a bookmark saves it in local storage and updates the view model
    func test_bookmarksViewModel_addBookmark() {
        // Given: Create a mock article to save
        let article = Article(
            source: Source(
                id: "bbc-news",
                name: "BBC News",
                description: "Global news",
                url: "https://bbc.com",
                category: "general",
                language: "en",
                country: "gb"
            ),
            author: "Author",
            title: "Sample Article",
            description: "Article description",
            url: "https://bbc.com/article1",
            urlToImage: "https://bbc.com/article1.jpg",
            publishedAt: Date(),
            content: "Full article content here..."
        )

        // When: Save the article to the local storage
        mockLocalStorage.saveBookmark(article: article)
        viewModel.fetchAllBookmarks()

        // Then: The bookmarks array should now contain the added article
        XCTAssertEqual(viewModel.bookmarks.count, 1, "Bookmarks array should contain 1 item.")
        XCTAssertEqual(
            viewModel.bookmarks.first?.url,
            article.url,
            "The saved article should match the one in the bookmarks."
        )
    }

    // Test: Removing a bookmark updates the bookmarks array and removes it from local storage
    func test_bookmarksViewModel_removeBookmark() {
        // Given: Create and add two mock articles to the local storage
        let article1 = Article(
            source: Source(
                id: "bbc-news",
                name: "BBC News",
                description: "Global news",
                url: "https://bbc.com",
                category: "general",
                language: "en",
                country: "gb"
            ),
            author: "Author",
            title: "Sample Article 1",
            description: "Article description 1",
            url: "https://bbc.com/article1",
            urlToImage: "https://bbc.com/article1.jpg",
            publishedAt: Date(),
            content: "Full article content here..."
        )

        let article2 = Article(
            source: Source(
                id: "bbc-news",
                name: "BBC News",
                description: "Global news",
                url: "https://bbc.com",
                category: "general",
                language: "en",
                country: "gb"
            ),
            author: "Author",
            title: "Sample Article 2",
            description: "Article description 2",
            url: "https://bbc.com/article2",
            urlToImage: "https://bbc.com/article2.jpg",
            publishedAt: Date(),
            content: "Full article content here..."
        )

        mockLocalStorage.saveBookmark(article: article1)
        mockLocalStorage.saveBookmark(article: article2)
        viewModel.fetchAllBookmarks()

        // When: Remove one bookmark
        viewModel.removeBookmark(indexSet: IndexSet([0]))

        // Then: Only one remain in the bookmarks array
        XCTAssertEqual(viewModel.bookmarks.count, 1, "There should be 1 bookmark left.")
    }

    // Test: Fetching all bookmarks updates the array when new bookmarks are added
    func test_bookmarksViewModel_fetchAllBookmarks_whenNewBookmarksAdded() {
        // Given: Create and add a mock article
        let article1 = Article(
            source: Source(
                id: "bbc-news",
                name: "BBC News",
                description: "Global news",
                url: "https://bbc.com",
                category: "general",
                language: "en",
                country: "gb"
            ),
            author: "Author",
            title: "Sample Article 1",
            description: "Article description 1",
            url: "https://bbc.com/article1",
            urlToImage: "https://bbc.com/article1.jpg",
            publishedAt: Date(),
            content: "Full article content here..."
        )

        // When: Add article and fetch bookmarks
        mockLocalStorage.saveBookmark(article: article1)
        viewModel.fetchAllBookmarks()

        // Then: The bookmarks array should contain 1 article
        XCTAssertEqual(viewModel.bookmarks.count, 1, "There should be 1 bookmark in the array.")
        XCTAssertEqual(
            viewModel.bookmarks.first?.url,
            article1.url,
            "The article's URL should match the one added."
        )
    }

    // Test: Fetching bookmarks when there are none should return an empty array
    func test_bookmarksViewModel_fetchAllBookmarks_whenNoBookmarks() {
        // When: Fetch bookmarks when no bookmarks are saved
        viewModel.fetchAllBookmarks()

        // Then: The bookmarks array should be empty
        XCTAssertTrue(
            viewModel.bookmarks.isEmpty,
            "Bookmarks array should be empty when no bookmarks are saved."
        )
    }
}
