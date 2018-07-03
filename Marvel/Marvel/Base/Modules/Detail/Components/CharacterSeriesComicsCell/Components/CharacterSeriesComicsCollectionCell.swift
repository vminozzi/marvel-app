//
//  CharacterSeriesComicsCollectionCell.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 02/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class CharacterSeriesComicsCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func fill(with dto: CharacterSeriesComicsCollectionCellDTO) {
        nameLabel.text = dto.name
    }
}
