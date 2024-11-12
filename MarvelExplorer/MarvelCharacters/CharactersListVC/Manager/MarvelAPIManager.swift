//
//  MarvelAPIManager.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation
import Moya

class MarvelAPIManager {
    typealias FetchCharactersCompletion = (Result<MarvelCharacterResponse, Error>) -> Void
    private let provider = MoyaProvider<MarvelCharactersService>()
    
    
    func fetchCharacters(pageSize: Int, nextPageOffset: Int, completion: @escaping FetchCharactersCompletion) {
            provider.request(.fetchMarvelCharacters(pageSize: pageSize,
                                                    nextPageOffset: nextPageOffset)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let marvelCharacterResponse = try decoder.decode(MarvelCharacterResponse.self, from: response.data)
                        completion(.success(marvelCharacterResponse))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
