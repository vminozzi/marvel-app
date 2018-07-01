//
//  HomeProtocols.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

protocol HomeInteractorProtocol: class {
    var feedbackDelegate: Feedback? { get set }
    var characters: [Character] { get }
    
    func getCharacters()
    func getCharacter(with name: String)
    func cancelSearch()
    func refresh()
    func getFavorites()
    func isFavorite(character: Character) -> Bool
    func favorite(character id: Int, contentType: ContentType)
    func searchFavorite(character name: String)
}

protocol Feedback: class {
    func feedback(error: String?)
    func didLoadImage(identifier: String)
}

protocol HomePresenterProtocol: class {
    var interactor: HomeInteractorProtocol { get set }
    var imageCache: ImageCache { get set }
    var canLoadMore: Bool { get set }
    var contentType: ContentType { get set }
    
    func load()
    func searchCharacter(name: String)
    func cancelSerch()
    func numberOfSections() -> Int
    func numberOfItems() -> Int 
    func getCharacterDTO(index: Int) -> CharacterDTO
    func didSelect(row: Int) -> DetailCharacterDTO
}

protocol CharacterFavoriteDelegate: class {
    func favorite(with identifier: Int)
}
