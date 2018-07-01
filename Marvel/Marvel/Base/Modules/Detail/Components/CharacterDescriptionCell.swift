//
//  CharacterDescriptionCell.swift
//  Marvel
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class CharacterDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func fill(with data: CharacterDescriptionDTO) {
        descriptionLabel.text = data.description
    }
}
