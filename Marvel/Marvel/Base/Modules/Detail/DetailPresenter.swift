//
//  DetailPresenter.swift
//  Marvel
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: - Attributes
    weak var feedbackDelegate: Feedback?
    fileprivate var numberOfsections = 2
    var character = DetailCharacterDTO() {
        didSet {
            if character.comics.count > 0 {
                numberOfsections += 1
            }
            
            if character.series.count > 0 {
                numberOfsections += 1
            }
        }
    }
    
    // MARK: - DetailPresenterProtocol
    func loadContent(character: DetailCharacterDTO) {
        numberOfsections = 2
        self.character = character
    }
    
    func numberOfSections() -> Int {
        return numberOfsections
    }
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func getThumbnailCellDTO() -> CharacterThumbnailDTO {
        return CharacterThumbnailDTO(path: character.thumbnail, image: character.image)
    }
    
    func getDescriptionCellDTO() -> CharacterDescriptionDTO {
        return CharacterDescriptionDTO(description: character.description)
    }
    
    func getSeriesCellDTO() -> CharacterSeriesComicsDTO {
        if character.series.count > 0 {
            return CharacterSeriesComicsDTO(items: character.series)
        }
        return getComicsCellDTO()
    }
    
    func getComicsCellDTO() -> CharacterSeriesComicsDTO {
        return CharacterSeriesComicsDTO(items: character.comics)
    }
    
    func titleForHeaderIn(section: Int) -> String {
        guard let type = DetailCellType(rawValue: section) else {
            return ""
        }
        
        switch type {
        case .series:
            return character.series.count > 0 ? "Series" : "Comics"
        case .comics:
            return "Comics"
        default:
            return ""
        }
    }
}
