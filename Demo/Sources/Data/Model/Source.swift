// Copyright © 2024 Evan Su. All rights reserved.

import Foundation

struct Source: Decodable, Identifiable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}

struct SourcesResponse: Decodable {
    let status: String?
    let sources: [Source]?
}
