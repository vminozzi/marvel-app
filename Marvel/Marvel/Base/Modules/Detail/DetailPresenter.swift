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
    var data = DetailCharacterDTO() {
        didSet {
            if data.character.comics?.items.count ?? 0 > 0 {
                numberOfsections += 1
            }
            
            if data.character.series?.items.count ?? 0 > 0 {
                numberOfsections += 1
            }
        }
    }
    fileprivate var interactor: DetailInteractorProtocol
    
    init(interactor: DetailInteractorProtocol = DetailInteractor()) {
        self.interactor = interactor
    }
    
    // MARK: - DetailPresenterProtocol
    func loadContent(character: DetailCharacterDTO) {
        numberOfsections = 2
        self.data = character
    }
    
    func numberOfSections() -> Int {
        return numberOfsections
    }
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func getThumbnailCellDTO() -> CharacterThumbnailDTO {
        return CharacterThumbnailDTO(path: data.character.thumbnail?.file ?? "", image: data.image)
    }
    
    func getDescriptionCellDTO() -> CharacterDescriptionDTO {
        return CharacterDescriptionDTO(description: data.character.description ?? "")
    }
    
    func getSeriesCellDTO() -> CharacterSeriesComicsDTO {
        if let series = data.character.series, series.items.count > 0 {
            return CharacterSeriesComicsDTO(items: series.items)
        }
        return getComicsCellDTO()
    }
    
    func getComicsCellDTO() -> CharacterSeriesComicsDTO {
        if let comics = data.character.comics, comics.items.count > 0 {
            return CharacterSeriesComicsDTO(items: comics.items)
        }
        return CharacterSeriesComicsDTO()
    }
    
    func titleForHeaderIn(section: Int) -> String {
        guard let type = DetailCellType(rawValue: section) else {
            return ""
        }
        
        switch type {
        case .series:
            return data.character.series?.items.count ?? 0 > 0 ? "Series" : "Comics"
        case .comics:
            return "Comics"
        default:
            return ""
        }
    }
    
    func didFavoriteCharacter() {
        interactor.didFavorite(character: data.character)
    }
    
    func isFavorite() -> Bool {
        return interactor.isFavorite(character: data.character)
    }
}
