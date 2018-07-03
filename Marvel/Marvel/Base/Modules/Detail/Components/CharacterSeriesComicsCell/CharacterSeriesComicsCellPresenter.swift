//
//  CharacterSeriesComicsCellPresenter.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 02/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class CharacterSeriesComicsCellPresenter: CharacterSeriesComicsCellPresenterProtocol {
    
    // MARK: - Attributes
    fileprivate var items = [Item]()
    
    // MARK: - CharacterSeriesComicsCellPresenterProtocol
    func load(with items: [Item]) {
        self.items = items
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func getCollectionCellDTO(at index: Int) -> CharacterSeriesComicsCollectionCellDTO {
        guard let item = items.element(at: index) else {
            return CharacterSeriesComicsCollectionCellDTO()
        }
        return CharacterSeriesComicsCollectionCellDTO(name: item.name)
    }
}
