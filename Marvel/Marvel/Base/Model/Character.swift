//
//  Character.swift
//  Marvel
//
//  Created by Bruno Santos on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

struct Character: Codable, Equatable {
    
    var id = 0
    var name = ""
    var description: String? = ""
    var thumbnail: Thumbnail?
    var comics: Comics?
    var series: Series?
}
