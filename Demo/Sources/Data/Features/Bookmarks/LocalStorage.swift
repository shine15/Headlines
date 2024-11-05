// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

protocol LocalStorageProtocol {
    func saveBookmark(article: Article)
    func fetchAllBookmarks() -> [Article]
    func removeBookmark(url: String)
    var allBookmarksURL: [String] { get }
}
