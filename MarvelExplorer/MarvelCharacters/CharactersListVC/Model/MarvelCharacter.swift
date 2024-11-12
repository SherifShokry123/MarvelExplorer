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
    let urls: [CharacterURL]
    let comics: ContentList?
    let series: ContentList?
    let events: ContentList?
    let stories: ContentList?
}

struct CharacterThumbnail: Codable {
    let path: String
    let `extension`: String
    
    var imageURL: String {
        return "\(path).\(`extension`)"
    }
}

struct CharacterURL: Codable {
    let type: String
    let url: String
}

struct ContentList: Codable {
    let available: Int
    let collectionURI: String
    let items: [ContentSummary]
}

struct ContentSummary: Codable {
    let resourceURI: String
    let name: String
    
    var imageURL: String {
        let publicKey = Constants.Networking.publicKey
        let privateKey = Constants.Networking.privateKey
        
        // Generate timestamp (ts)
        let ts = "\(Date().timeIntervalSince1970)"
        
        // Generate the MD5 hash for authentication
        let hash = "\(ts)\(privateKey)\(publicKey)".md5()
        
        // Construct the image URL by using the thumbnail path and extension
        let imageURL = "\(resourceURI)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        
        return imageURL
    }
}
