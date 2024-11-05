// Copyright © 2024 Evan Su. All rights reserved.

import CoreData
import Foundation

final class LocalStorageManager: LocalStorageProtocol {
    static let shared = LocalStorageManager()

    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    private init() {
        container = NSPersistentContainer(name: "ArticlesContainer")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
    }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func saveBookmark(article: Article) {
        let newBookmark = ArticleEntity(context: context)
        newBookmark.title = article.title
        newBookmark.desc = article.description
        newBookmark.image = article.urlToImage
        newBookmark.url = article.url
        newBookmark.publishedAt = article.publishedAt
        newBookmark.author = article.author
        saveContext()
    }

    func fetchAllBookmarks() -> [Article] {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        let bookmarks = (try? context.fetch(request)) ?? []
        return bookmarks.map {
            Article(
                source: nil,
                author: $0.author,
                title: $0.title,
                description: $0.desc,
                url: $0.url,
                urlToImage: $0.image,
                publishedAt: $0.publishedAt,
                content: nil
            )
        }
    }

    func removeBookmark(url: String) {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", url)
        let bookmarks = try? context.fetch(request)
        if let bookmarkToDelete = bookmarks?.first {
            context.delete(bookmarkToDelete)
            saveContext()
        }
    }

    var allBookmarksURL: [String] {
        fetchAllBookmarks().compactMap(\.url)
    }
}
