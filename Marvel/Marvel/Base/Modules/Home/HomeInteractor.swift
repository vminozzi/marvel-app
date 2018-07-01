//
//  HomeInteractor.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    weak var feedbackDelegate: Feedback?
    var characters = [Character]()
    var allCharacters = [Character]()
    var favorites = [Character]()
    fileprivate var dataManager = UserDefaultsManager()
    
    func getCharacters() {
        favorites = dataManager.loadCharacters() ?? [Character]()
        CharactersRequest(offset: characters.count).request { data, error in
            guard let data = data, let results = data.results else {
                self.feedbackDelegate?.feedback(error: error?.message)
                return
            }
            self.characters.append(contentsOf: results)
            self.allCharacters = self.characters
            self.feedbackDelegate?.feedback(error: nil)
        }
    }
    
    func getCharacter(with name: String) {
        favorites = dataManager.loadCharacters() ?? [Character]()
        CharactersRequest(name: name).request { data, error in
            guard let data = data, let results = data.results else {
                self.feedbackDelegate?.feedback(error: error?.message)
                return
            }
            self.characters = results
            self.feedbackDelegate?.feedback(error: nil)
        }
    }
    
    func cancelSearch() {
        characters = allCharacters
        feedbackDelegate?.feedback(error: nil)
    }
    
    func refresh() {
        characters.removeAll()
        getCharacters()
    }
    
    func getFavorites() {
        characters.removeAll()
        favorites = dataManager.loadCharacters() ?? [Character]()
        characters = favorites
        feedbackDelegate?.feedback(error: nil)
    }
    
    func isFavorite(character: Character) -> Bool {
        return favorites.filter { $0 == character }.count > 0
    }
    
    func favorite(character id: Int, contentType: ContentType) {
        if let remove = favorites.filter({ $0.id == id }).first {
            dataManager.remove(character: remove)
        } else {
            guard let character = characters.filter({ $0.id == id }).first else {
                return
            }
            dataManager.save(character: character)
        }
        favorites = dataManager.loadCharacters() ?? [Character]()
        if contentType == .favorites {
            characters = favorites
        }
        feedbackDelegate?.feedback(error: nil)
    }
    
    func searchFavorite(character name: String) {
        if name.isEmpty {
            favorites = dataManager.loadCharacters() ?? [Character]()
        } else {
            favorites = favorites.filter { $0.name.lowercased().contains(name.lowercased()) }
        }
        characters = favorites
        feedbackDelegate?.feedback(error: nil)
    }
}
