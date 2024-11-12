//
//  MarvelCharactersDetailsViewModel.swift
//  MarvelExplorer
//
//  Created by Sherif Shokry on 12/11/2024.
//

import Foundation
import Combine

enum HomeSectionType {
    case mainImage
    case characterInfo(title: String, description: String)
    case content(title: String, contentItems: [ContentSummary])
    case relatedLinks
}


class MarvelCharactersDetailsViewModel {
    let marvelCharacter: MarvelCharacter
    var detailsSectionsSubject = CurrentValueSubject<[HomeSectionType], Never>([])
    
    init(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
    }
    
    
    func makeDetailSections() {
        var sections: [HomeSectionType] = []
        
        sections.append(.mainImage)
        
        if !marvelCharacter.name.isEmpty {
            sections.append(.characterInfo(title: "Name", description: marvelCharacter.name))
        }
        
        if !marvelCharacter.description.isEmpty {
            sections.append(.characterInfo(title: "Description", description: marvelCharacter.description))
        }
        
        if let comics = marvelCharacter.comics, !comics.items.isEmpty {
            sections.append(.content(title: "COMICS", contentItems: comics.items))
        }
        
        if let series = marvelCharacter.series, !series.items.isEmpty {
            sections.append(.content(title: "SERIES", contentItems: series.items))
        }
        
        if let events = marvelCharacter.events, !events.items.isEmpty {
            sections.append(.content(title: "EVENTS", contentItems: events.items))
        }
        
        if !marvelCharacter.urls.isEmpty {
            sections.append(.relatedLinks)
        }
        
        detailsSectionsSubject.send(sections)
    }
    
    
}
