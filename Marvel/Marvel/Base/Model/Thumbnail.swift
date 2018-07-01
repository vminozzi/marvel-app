//
//  Thumbnail.swift
//  Marvel
//
//  Created by Bruno Santos on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

struct Thumbnail: Codable, Equatable {
    
    var path = ""
    var pathExtension = ""
    
    var file: String {
        return path +  "." + pathExtension
    }
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case pathExtension = "extension"
    }
}
