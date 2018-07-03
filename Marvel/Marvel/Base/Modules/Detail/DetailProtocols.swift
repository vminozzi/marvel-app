//
//  DetailProtocols.swift
//  Marvel
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

enum DetailCellType: Int {
    case thumbnail = 0
    case description = 1
    case series = 2
    case comics = 3
}

struct DetailCharacterDTO {
    var character = Character()
    var image: UIImage?
}

struct CharacterThumbnailDTO {
    var path = ""
    var image: UIImage?
}

struct CharacterDescriptionDTO {
    var description = ""
}

struct CharacterSeriesComicsDTO {
    var items = [Item]()
}

protocol DetailPresenterProtocol: class {
    func loadContent(character: DetailCharacterDTO)
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func getThumbnailCellDTO() -> CharacterThumbnailDTO
    func getDescriptionCellDTO() -> CharacterDescriptionDTO
    func getSeriesCellDTO() -> CharacterSeriesComicsDTO
    func getComicsCellDTO() -> CharacterSeriesComicsDTO
    func didFavoriteCharacter()
    func isFavorite() -> Bool
}

protocol DetailInteractorProtocol: class {
    func didFavorite(character: Character)
    func isFavorite(character: Character) -> Bool
}

protocol DetailViewDegelgate: class {
    func didReload()
}
