// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import XCTest

final class HeadlineRowViewModelTests: XCTestCase {
    private var viewModel1: HeadlineRowViewModel!
    private var viewModel2: HeadlineRowViewModel!

    private let article1 = Article(
        source: Source(
            id: "abc-news",
            name: "ABC News",
            description: "Breaking news from ABC",
            url: "https://abcnews.com",
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

    private let article2 = Article(
        source: Source(
            id: "abc-news",
            name: "ABC News",
            description: "Breaking news from ABC",
            url: "https://abcnews.com",
            category: "general",
            language: "en",
            country: "us"
        ),
        author: "Author2",
        title: "ABC Update: Politics",
        description: "A summary of political events today.",
        url: "https://abcnews.com/article2",
        urlToImage: "https://abcnews.com/article2.jpg",
        publishedAt: Calendar.current.date(byAdding: .minute, value: -30, to: Date())!,
        content: "Full article content here..."
    )

    override func setUp() {
        super.setUp()
        viewModel1 = HeadlineRowViewModel(article: article1)
        viewModel2 = HeadlineRowViewModel(article: article2)
    }

    override func tearDown() {
        viewModel1 = nil
        viewModel2 = nil
        super.tearDown()
    }

    // Test Title
    func test_headlineRowViewModel_title() {
        XCTAssertEqual(
            viewModel1.title,
            "ABC News: Breaking News Today",
            "The title should match the article title."
        )
        XCTAssertEqual(viewModel2.title, "ABC Update: Politics", "The title should match the article title.")
    }

    // Test Image URL
    func test_headlineRowViewModel_imageURL() {
        XCTAssertEqual(
            viewModel1.imageURL,
            "https://abcnews.com/article1.jpg",
            "The image URL should match the article's image URL."
        )
        XCTAssertEqual(
            viewModel2.imageURL,
            "https://abcnews.com/article2.jpg",
            "The image URL should match the article's image URL."
        )
    }

    // Test Description
    func test_headlineRowViewModel_description() {
        XCTAssertEqual(
            viewModel1.description,
            "An update on the latest breaking news from ABC News.",
            "The description should match the article description."
        )
        XCTAssertEqual(
            viewModel2.description,
            "A summary of political events today.",
            "The description should match the article description."
        )
    }

    // Test Author and Time Ago
    func test_headlineRowViewModel_author_with_timeAgo() {
        let expectedAuthor1 = "2 hours ago • Author1"
        let expectedAuthor2 = "30 minutes ago • Author2"

        XCTAssertEqual(
            viewModel1.author,
            expectedAuthor1,
            "The author should be displayed along with the time ago for the first article."
        )
        XCTAssertEqual(
            viewModel2.author,
            expectedAuthor2,
            "The author should be displayed along with the time ago for the second article."
        )
    }
}
