// Copyright © 2024 Evan Su. All rights reserved.

@testable import Demo
import Foundation

final class NewsAPIServiceStub: NewsAPIServiceProtocol {
    // Stubbed data for `fetchHeadlines`
    func fetchHeadlines(source: String) async throws -> [Article] {
        switch source {
        case "abc-news":
            [
                Article(
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
                ),
                Article(
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
            ]

        case "bbc-news":
            [
                Article(
                    source: Source(
                        id: "bbc-news",
                        name: "BBC News",
                        description: "BBC's latest news updates",
                        url: "https://bbc.com",
                        category: "general",
                        language: "en",
                        country: "gb"
                    ),
                    author: "Emily Brown",
                    title: "BBC: Global Headlines",
                    description: "Latest global headlines from BBC.",
                    url: "https://bbc.com/article1",
                    urlToImage: "https://bbc.com/article1.jpg",
                    publishedAt: Date(),
                    content: "Full article content here..."
                ),
                Article(
                    source: Source(
                        id: "bbc-news",
                        name: "BBC News",
                        description: "BBC's latest news updates",
                        url: "https://bbc.com",
                        category: "general",
                        language: "en",
                        country: "gb"
                    ),
                    author: "Robert Johnson",
                    title: "BBC Politics Update",
                    description: "Political news and analysis from BBC.",
                    url: "https://bbc.com/article2",
                    urlToImage: "https://bbc.com/article2.jpg",
                    publishedAt: Date(),
                    content: "Full article content here..."
                )
            ]

        default:
            throw NetworkError.unknown
        }
    }

    // Stubbed data for `fetchAllSources`
    func fetchAllSources() async throws -> [Source] {
        // Returning some predefined sources
        [
            Source(
                id: "abc-news",
                name: "ABC News",
                description: "Breaking news from ABC",
                url: "https://abcnews.com",
                category: "general",
                language: "en",
                country: "us"
            ),
            Source(
                id: "bbc-news",
                name: "BBC News",
                description: "Global news from BBC",
                url: "https://bbc.com",
                category: "general",
                language: "en",
                country: "gb"
            ),
            Source(
                id: "cnn",
                name: "CNN",
                description: "CNN's latest updates",
                url: "https://cnn.com",
                category: "general",
                language: "en",
                country: "us"
            )
        ]
    }
}
