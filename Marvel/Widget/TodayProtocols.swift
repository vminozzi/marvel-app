//
//  TodayProtocols.swift
//  Widget
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

protocol Feedback: class {
    func didLoad()
}

struct CharacterDTO {
    var name = ""
    var imageURL = ""
}

protocol TodayPresenterProtocol: class {
    func load()
    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func getCharacterDTO(at index: Int) -> CharacterDTO
}
