//
//  CharacterThumbnailCell.swift
//  Marvel
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class CharacterThumbnailCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func fill(with data: CharacterThumbnailDTO) {
        guard let image = data.image else {
            downloadImage(path: data.path)
            return
        }
        self.thumbnailImageView.image = image
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
