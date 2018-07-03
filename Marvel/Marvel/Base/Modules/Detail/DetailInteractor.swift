//
//  DetailInteractor.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 03/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class DetailInteractor: DetailInteractorProtocol {
    
    let dataManager = UserDefaultsManager()
    
    func didFavorite(character: Character) {
        if let data = dataManager.loadCharacters()?.filter({ $0 == character }).first {
            dataManager.remove(character: data)
        } else {
            dataManager.save(character: character)
        }
    }
    
    func isFavorite(character: Character) -> Bool {
        return dataManager.loadCharacters()?.filter({ $0 == character }).count ?? 0 > 0
    }
}
