//
//  HomePresenter.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

enum ContentType: Int {
    case home = 0
    case favorites = 1
}

class HomePresenter: HomePresenterProtocol {
    
    // MARK: - Attributes
    var interactor: HomeInteractorProtocol
    var imageCache = ImageCache()
    var canLoadMore = true
    var contentType: ContentType = .home
    fileprivate var isSearching = false
    
    // MARK: - Init
    init(view: Feedback, interactor: HomeInteractorProtocol = HomeInteractor()) {
        self.interactor = interactor
        self.interactor.feedbackDelegate = view
        imageCache.feedbackDelegate = view
    }
    
    // MARK: - HomePresenterProtocol
    func load() {
        if contentType == .home {
            if canLoadMore && !isSearching {
                canLoadMore = false
                interactor.getCharacters()
            }
        } else {
            interactor.getFavorites()
        }
    }
    
    func searchCharacter(name: String) {
        if contentType == .home {
            if !name.isEmpty {
                isSearching = true
                canLoadMore = false
                interactor.getCharacter(with: name)
            } else {
                cancelSerch()
            }
        } else {
            interactor.searchFavorite(character: name)
        }
    }
    
    func cancelSerch() {
        isSearching = false
        interactor.cancelSearch()
        canLoadMore = true
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return interactor.characters.count
    }
    
    func getCharacterDTO(index: Int) -> CharacterDTO {
        guard let character = interactor.characters.element(at: index) else {
            return CharacterDTO()
        }
        let file = character.thumbnail?.file ?? ""
        return CharacterDTO(id: character.id,
                            name: character.name,
                            thumbnail: file,
                            image: imageCache.getImage(string: file),
                            favorite: interactor.isFavorite(character: character))
    }
    
    func didSelect(row: Int) -> DetailCharacterDTO {
        guard let character = interactor.characters.element(at: row) else {
            return DetailCharacterDTO()
        }
        
        let file = character.thumbnail?.file ?? ""
        return DetailCharacterDTO(id: character.id,
                                  name: character.name,
                                  description: character.description ?? "",
                                  thumbnail: file,
                                  series: character.series?.items ?? [Item](),
                                  comics: character.comics?.items ?? [Item](),
                                  image: imageCache.getImage(string: file))
    }
}
