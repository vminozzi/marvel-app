//
//  CharactersResults.swift
//  Marvel
//
//  Created by Bruno Santos on 30/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

struct CharactersResult: Mappable {
    
    var data: CharactersData?
    
    init?(data: Data) {
        guard let decoded = try? JSONDecoder().decode(CharactersResult.self, from: data) else {
            return nil
        }
        self = decoded
    }
}
