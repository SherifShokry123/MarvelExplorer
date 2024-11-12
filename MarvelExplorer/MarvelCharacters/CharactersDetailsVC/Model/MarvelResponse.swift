//
//  MarvelResponse.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation

// MARK: - MarvelResponse
struct MarvelResponse: Codable {
    let data: MarvelData
}

// MARK: - MarvelData
struct MarvelData: Codable {
    let results: [Comic]
}

// MARK: - Comic
struct Comic: Codable {
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let `extension`: String

    // Computed property to return the full image URL
    var imageURL: String {
        return "\(path).\(`extension`)"
    }
}
