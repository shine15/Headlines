// Copyright © 2024 Evan Su. All rights reserved.

import SwiftUI

@MainActor
final class NewsDetailViewModel: ObservableObject {
    private let article: Article
    private let localStorage: LocalStorageProtocol

    @Published private(set) var isSaved: Bool = false

    init(article: Article, localStorage: LocalStorageProtocol) {
        self.article = article
        self.localStorage = localStorage
    }

    var url: URL? {
        URL(string: article.url ?? "")
    }

    func toggleSaved() {
        if isSaved {
            localStorage.removeBookmark(url: article.url ?? "")
        } else {
            localStorage.saveBookmark(article: article)
        }
        isSaved.toggle()
    }

    func checkSaved() {
        isSaved = localStorage.allBookmarksURL.contains(article.url ?? "")
    }
}
