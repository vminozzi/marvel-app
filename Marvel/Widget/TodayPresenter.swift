//
//  TodayPresenter.swift
//  Widget
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class TodayPresenter: TodayPresenterProtocol {
    
    weak var feedbackDelegte: Feedback?
    var characters = [Character]()
    
    init(view: Feedback) {
        feedbackDelegte = view
    }
    
    func load() {
        CharactersRequest(limit: 3).request { data, error in
            guard let characters = data?.results else {
                return
            }
            self.characters = characters
            self.feedbackDelegte?.didLoad()
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return characters.count
    }
    
    func getCharacterDTO(at index: Int) -> CharacterDTO {
        guard let character = characters.element(at: index) else {
            return CharacterDTO()
        }
        return CharacterDTO(name: character.name, imageURL: character.thumbnail?.file ?? "")
    }
}
