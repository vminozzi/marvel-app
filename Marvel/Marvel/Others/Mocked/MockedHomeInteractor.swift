//
//  MockedHomeInteractor.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 03/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class MockedHomeInteractor: HomeInteractorProtocol {
    
    weak var feedbackDelegate: Feedback?
    var characters = [Character]()
    var allCharacters = [Character]()
    var favorites = [Character]()
    fileprivate var dataManager = UserDefaultsManager()
    
    func loadFavorite() {
        favorites = dataManager.loadCharacters() ?? [Character]()
        feedbackDelegate?.feedback(error: nil)
    }
    
    func getCharacters() {
        guard let mocked = CharactersResult(data: readJSON(name: "MockedCharactersResult") ?? Data()), let characters = mocked.data?.results else {
            return
        }
        self.characters = characters
    }
    
    func getCharacter(with name: String) {
        
    }
    
    func cancelSearch() {
        
    }
    
    func refresh() {
        
    }
    
    func getFavorites() {
        characters.removeAll()
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
            if let character = characters.filter({ $0.id == id }).first {
                dataManager.save(character: character)
            }
        }
        
        loadFavorite()
        if contentType == .favorites {
            characters = favorites
        }
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
    
    func readJSON(name: String) -> Data? {
        let path = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }
}
