//
//  MarvelCharacter.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation

struct MarvelCharacterResponse: Codable {
    let data: CharacterData
}

struct CharacterData: Codable {
    let results: [MarvelCharacter]
}

struct MarvelCharacter: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: CharacterThumbnail
}

struct CharacterThumbnail: Codable {
    let path: String
    let `extension`: String
    
    var imageURL: String {
        return "\(path).\(`extension`)"
    }
}
