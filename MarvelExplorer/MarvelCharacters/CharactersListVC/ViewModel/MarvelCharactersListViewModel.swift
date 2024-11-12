//
//  MarvelCharactersListViewModel.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 11/11/2024.
//

import Foundation
import Combine

class MarvelCharactersListViewModel {
    private let marvelAPIClient = MarvelAPIManager()
    
    enum ListState {
        case failed
        case empty
        case loading
        case loaded
    }
    
    var charactersSubject = CurrentValueSubject<[MarvelCharacter], Never>([])
    var listStateSubject = CurrentValueSubject<ListState, Never>(.empty)
    
    private var characters: [MarvelCharacter] = []
    private var currentPage = 0
    private lazy var pageSize = 20
    private var reachedEnd = false
    
    func fetchCharactersData() {
        guard listStateSubject.value != .loading else { return }
        
        listStateSubject.send(.loading)
        
        let nextPageOffset = currentPage * pageSize
        marvelAPIClient.fetchCharacters(pageSize: pageSize,
                                        nextPageOffset: nextPageOffset) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case let .success(marvelCharacterResponse):
                handleFetchSuccess(result: marvelCharacterResponse)
            case let .failure(error):
                handleFetchFailure(error: error)
            }
        }
    }
    
    private func handleFetchSuccess(result: MarvelCharacterResponse) {
        let newCharacters = result.data.results
        
        // Append new characters to the current list
        characters.append(contentsOf: newCharacters)
        charactersSubject.send(characters)
        
        updatePaginationState(newCharacters: newCharacters)
    }
    
    private func updatePaginationState(newCharacters: [MarvelCharacter]) {
        reachedEnd = newCharacters.count < pageSize
        listStateSubject.send(characters.isEmpty ? .empty : .loaded)
    }
    
    private func handleFetchFailure(error: Error) {
        debugPrint("[MarvelCharactersListViewModel] Error fetching characters data: \(error.localizedDescription)")
        listStateSubject.send(.failed)
    }
    
    func fetchMoreCharacters() {
        if listStateSubject.value != .loading, !reachedEnd {
            currentPage += 1
            fetchCharactersData()
        }
    }
}
