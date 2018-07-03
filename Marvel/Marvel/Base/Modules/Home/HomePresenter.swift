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
    var router: HomeRouter?
    var imageCache = ImageCache()
    var canLoadMore = true
    var contentType: ContentType = .home
    fileprivate var isSearching = false
    
    // MARK: - Init
    init(view: Feedback? = nil, interactor: HomeInteractorProtocol = HomeInteractor(), routerProtocol: HomeRouterProtocol? = nil) {
        self.interactor = interactor
        self.interactor.feedbackDelegate = view
        imageCache.feedbackDelegate = view
        router = HomeRouter(view: routerProtocol)
    }
    
    // MARK: - HomePresenterProtocol
    func load() {
        interactor.loadFavorite()
        if contentType == .home {
            if interactor.characters.isEmpty {
                canLoadMore = false
                interactor.getCharacters()
            }
        } else {
            interactor.getFavorites()
        }
    }
    
    func loadMore() {
        if canLoadMore && !isSearching {
            canLoadMore = false
            interactor.getCharacters()
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
    
    func didSelect(row: Int) {
        guard let character = interactor.characters.element(at: row) else {
            return
        }
        
        let file = character.thumbnail?.file ?? ""
        let detail =  DetailCharacterDTO(character: character, image: imageCache.getImage(string: file))
        router?.showDetail(detailData: detail)
    }
    
    func refresh() {
        interactor.refresh()
    }
    
    func didFavorite(characterId: Int) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            router?.reloadFavorite(characterId: characterId)
        }
        interactor.favorite(character: characterId, contentType: contentType)
    }
}
