//
//  MarvelCharactersListViewModelTests.swift
//  MarvelExplorerTests
//
//  Created by Sherif Shokry on 12/11/2024.
//

import XCTest
import Combine
@testable import MarvelExplorer

final class MarvelCharactersListViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func test_fetchCharactersList_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        let expectation = expectation(description: "Waiting for error state from listStateSubject")
        
        sut.fetchCharactersData()
        
        sut.listStateSubject
            .dropFirst()
            .sink(receiveValue: { listState in
                switch listState {
                case .failed:
                    expectation.fulfill()
                default:
                    XCTFail("Expected to receive only a failure state.")
                }
            })
            .store(in: &cancellables)
        
        client.complete(with: anyNSError())
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_fetchCharactersList_deliversSuccessOnClientSuccess() {
        let (sut, client) = makeSUT()
        let expectation = expectation(description: "Waiting for success state from listStateSubject")
        
        sut.fetchCharactersData()
        
        sut.listStateSubject
            .dropFirst()
            .sink(receiveValue: { listState in
                switch listState {
                case .loaded:
                    expectation.fulfill()
                default:
                    XCTFail("Expected to receive only a loaded state.")
                }
            })
            .store(in: &cancellables)
        
        client.complete(with: makeMarvelCharacterResponse())
        
        wait(for: [expectation], timeout: 1.0)
    }
    

    //MARK: - Helpers
    
    func makeSUT() -> (sut: MarvelCharactersListViewModel,
                       marvelAPIClientSpy: MarvelAPIClientSpy) {
        let marvelAPIClientSpy = MarvelAPIClientSpy()
        let sut = MarvelCharactersListViewModel(marvelAPIClient: marvelAPIClientSpy)
        
        trackForMemoryLeaks(sut)
        
        return (sut: sut, marvelAPIClientSpy: marvelAPIClientSpy)
    }
    
    private func makeMarvelCharacterResponse() -> MarvelCharacterResponse {
        return MarvelCharacterResponse(data: makeCharacterData())
    }
    
    private func makeCharacterData() -> CharacterData {
        CharacterData(results: [makeMarvelCharacterItem()])
    }
    
    private func makeMarvelCharacterItem(characterName: String = "any-name") -> MarvelCharacter {
        MarvelCharacter(id: Int(UUID().uuidString) ?? 0,
                        name: characterName,
                        description: "any-description",
                        thumbnail: CharacterThumbnail(path: "", extension: ""),
                        urls: [],
                        comics: nil,
                        series: nil,
                        events: nil,
                        stories: nil)
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0, userInfo: nil)
    }
}
