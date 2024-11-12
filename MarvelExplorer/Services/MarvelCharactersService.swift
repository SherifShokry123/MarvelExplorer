//
//  MarvelCharactersService.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 11/11/2024.
//

import Foundation
import Moya

enum MarvelCharactersService {
    case fetchMarvelCharacters(pageSize: Int, nextPageOffset: Int)
}

extension MarvelCharactersService: BaseService {
    var path: String {
        switch self {
        case .fetchMarvelCharacters:
            return "/characters"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchMarvelCharacters:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .fetchMarvelCharacters(pageSize, nextPageOffset):
            let publicKey = Constants.Networking.publicKey
            let privateKey = Constants.Networking.privateKey
            
            let ts = Date().timeIntervalSince1970
            let hash = "\(ts)\(privateKey)\(publicKey)".md5()
            
            let parameters: [String: Any] = [
                "apikey": publicKey,
                "ts": ts,
                "hash": hash,
                "limit": pageSize,
                "offset": nextPageOffset
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
