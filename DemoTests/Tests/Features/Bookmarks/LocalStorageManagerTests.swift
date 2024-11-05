// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

final class MockLocalStorageTests: XCTestCase {
    private var localStorage: MockLocalStorage!

    override func setUp() {
        super.setUp()
        localStorage = MockLocalStorage()
    }

    override func tearDown() {
        localStorage = nil
        super.tearDown()
    }

    // Test that saveBookmark saves an article properly
    func test_localStorage_saveBookmark() {
        // Given: A sample article
        let article = Article(
            source: nil,
            author: "Author",
            title: "Test Article",
            description: "This is a test article.",
            url: "https://www.example.com",
            urlToImage: "https://www.example.com/image.jpg",
            publishedAt: nil,
            content: "This is content"
        )

        // When: The article is saved to the MockLocalStorage
        localStorage.saveBookmark(article: article)

        // Then: The article should be saved in storage
        let savedArticles = localStorage.fetchAllBookmarks()
        XCTAssertEqual(savedArticles.count, 1, "There should be one saved article.")
        XCTAssertEqual(
            savedArticles.first?.url,
            article.url,
            "The saved article URL should match the input article URL."
        )
    }

    // Test that fetchAllBookmarks returns all saved articles
    func test_localStorage_fetchAllBookmarks() {
        // Given: A few sample articles
        let article1 = Article(
            source: nil,
            author: "Author 1",
            title: "Article 1",
            description: "Description 1",
            url: "https://www.example1.com",
            urlToImage: "https://www.example1.com/image1.jpg",
            publishedAt: nil,
            content: "Content 1"
        )
        let article2 = Article(
            source: nil,
            author: "Author 2",
            title: "Article 2",
            description: "Description 2",
            url: "https://www.example2.com",
            urlToImage: "https://www.example2.com/image2.jpg",
            publishedAt: nil,
            content: "Content 2"
        )

        localStorage.saveBookmark(article: article1)
        localStorage.saveBookmark(article: article2)

        // When: Fetch all saved bookmarks
        let bookmarks = localStorage.fetchAllBookmarks()

        // Then: Ensure both articles are returned
        XCTAssertEqual(bookmarks.count, 2, "There should be two saved articles.")
        XCTAssertTrue(
            bookmarks.contains(where: { $0.url == article1.url }),
            "The first bookmark should be in the fetched results."
        )
        XCTAssertTrue(
            bookmarks.contains(where: { $0.url == article2.url }),
            "The second bookmark should be in the fetched results."
        )
    }

    // Test that removeBookmark removes an article correctly
    func test_localStorage_removeBookmark() {
        // Given: A sample article
        let article = Article(
            source: nil,
            author: "Author",
            title: "Article to Remove",
            description: "Description to remove",
            url: "https://www.remove.com",
            urlToImage: "https://www.remove.com/image.jpg",
            publishedAt: nil,
            content: "Content to remove"
        )

        localStorage.saveBookmark(article: article)

        // When: The article is removed
        localStorage.removeBookmark(url: article.url ?? "")

        // Then: The article should no longer be in storage
        let savedArticles = localStorage.fetchAllBookmarks()
        XCTAssertEqual(savedArticles.count, 0, "The article should be removed from storage.")
    }

    // Test that allBookmarksURL returns all saved URLs
    func test_localStorage_allBookmarksURL() {
        // Given: A few sample articles
        let article1 = Article(
            source: nil,
            author: "Author 1",
            title: "Article 1",
            description: "Description 1",
            url: "https://www.example1.com",
            urlToImage: "https://www.example1.com/image1.jpg",
            publishedAt: nil,
            content: "Content 1"
        )
        let article2 = Article(
            source: nil,
            author: "Author 2",
            title: "Article 2",
            description: "Description 2",
            url: "https://www.example2.com",
            urlToImage: "https://www.example2.com/image2.jpg",
            publishedAt: nil,
            content: "Content 2"
        )

        localStorage.saveBookmark(article: article1)
        localStorage.saveBookmark(article: article2)

        // When: Fetch all bookmark URLs
        let urls = localStorage.allBookmarksURL

        // Then: Ensure both URLs are returned
        XCTAssertEqual(urls.count, 2, "There should be two bookmark URLs.")
        XCTAssertTrue(
            urls.contains(article1.url ?? ""),
            "The URL of the first saved article should be in the list of URLs."
        )
        XCTAssertTrue(
            urls.contains(article2.url ?? ""),
            "The URL of the second saved article should be in the list of URLs."
        )
    }
}
