//
//  CharacterCell.swift
//  Marvel
//
//  Created by Bruno Santos on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit

struct CharacterDTO {
    var id = 0
    var name = ""
    var thumbnail = ""
    var image: UIImage?
    var favorite = false
}

class CharacterCell: UICollectionViewCell {
    
    fileprivate var id = 0
    var identifier: String?
    weak var favoriteDelegate: CharacterFavoriteDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton?
    
    func fill(with dto: CharacterDTO) {
        id = dto.id
        nameLabel.text = dto.name
        identifier = dto.thumbnail
        setImage(with: dto.image)
        favoriteButton?.isSelected = dto.favorite
    }
    
    func setImage(with image: UIImage?) {
        DispatchQueue.main.async {
            self.thumbnailImageView.image = image
        }
    }
    
    @IBAction func favorite(button: UIButton) {
        button.isSelected = !button.isSelected
        favoriteDelegate?.favorite(with: id)
    }
}
