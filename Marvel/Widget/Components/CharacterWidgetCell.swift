//
//  CharacterCell.swift
//  Widget
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class CharacterWidgetCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func fill(with dto: CharacterDTO) {
        nameLabel.text = dto.name
        downloadImage(path: dto.imageURL)
    }
    
    func downloadImage(path: String) {
        if let url = URL(string: path) {
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = image
                    }
                }
            }).resume()
        }
    }
}
