// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

enum NewsRouter {
    case headlines(source: String)
    case sources
}

extension NewsRouter: EndPointProtocol {
    var urlString: String {
        switch self {
        case let .headlines(source):
            "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=cec5ee5ce2344a1fb37a3ad5cac6906a"
        case .sources:
            "https://newsapi.org/v2/top-headlines/sources?language=en&country=au&apiKey=cec5ee5ce2344a1fb37a3ad5cac6906a"
        }
    }
}
