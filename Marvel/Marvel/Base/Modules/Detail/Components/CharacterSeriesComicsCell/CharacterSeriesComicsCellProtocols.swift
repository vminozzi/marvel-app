//
//  CharacterSeriesComicsCellProtocols.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 02/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

struct CharacterSeriesComicsCollectionCellDTO {
    var name = ""
}

protocol CharacterSeriesComicsCellPresenterProtocol: class {
    func load(with items: [Item])
    func numberOfSections() -> Int
    func numberOfItems() -> Int
    func getCollectionCellDTO(at index: Int) -> CharacterSeriesComicsCollectionCellDTO
}
