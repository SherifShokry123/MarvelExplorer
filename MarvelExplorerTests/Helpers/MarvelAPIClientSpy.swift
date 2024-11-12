//
//  Spy.swift
//  MarvelExplorerTests
//
//  Created by Sherif Shokry on 12/11/2024.
//

@testable import MarvelExplorer

class MarvelAPIClientSpy: MarvelAPIManager {
    private var characterCompletion = [FetchCharactersCompletion]()
    
    func fetchCharacters(pageSize: Int, nextPageOffset: Int, completion: @escaping FetchCharactersCompletion) {
        characterCompletion.append(completion)
    }
    
    func complete(with error: Error, at index: Int = 0) {
        characterCompletion[index](.failure(error))
    }
    
    func complete(with response: MarvelCharacterResponse, at index: Int = 0) {
        characterCompletion[index](.success(response))
    }
}
