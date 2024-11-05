// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

final class HeadlineRowViewModel: ObservableObject {
    private let article: Article

    init(article: Article) {
        self.article = article
    }

    var title: String {
        article.title ?? ""
    }

    var imageURL: String? {
        article.urlToImage
    }

    var description: String {
        article.description ?? ""
    }

    var author: String {
        guard let date = article.publishedAt, let author = article.author else {
            return article.author ?? ""
        }
        return "\(date.timeAgo) • \(author)"
    }
}
