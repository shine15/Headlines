// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

protocol NewsAPIServiceProtocol {
    func fetchHeadlines(source: String) async throws -> [Article]
    func fetchAllSources() async throws -> [Source]
}

final class NewsAPIService: NewsAPIServiceProtocol {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager = NetworkManager(
        session: URLSession.shared,
        logger: AppLogger.network
    )) {
        self.networkManager = networkManager
    }

    func fetchHeadlines(source: String) async throws -> [Article] {
        let urlString = NewsRouter.headlines(source: source).urlString
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL(url: urlString)
        }
        let newsResp = try await networkManager.request(NewsResponse.self, request: URLRequest(url: url))
        return newsResp.articles ?? []
    }

    func fetchAllSources() async throws -> [Source] {
        let urlString = NewsRouter.sources.urlString
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL(url: urlString)
        }
        let sourcesResp = try await networkManager.request(
            SourcesResponse.self,
            request: URLRequest(url: url)
        )
        return sourcesResp.sources ?? []
    }
}
