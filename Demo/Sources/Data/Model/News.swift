// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

struct NewsResponse: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Decodable, Identifiable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    var id: String? {
        url
    }
}
