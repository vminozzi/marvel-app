//
//  BaseAPI.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 28/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

protocol Mappable: Decodable {
    init?(data: Data)
}

protocol Requestable: class {
    associatedtype DataType
    func request(completion: @escaping (_ result: DataType?, _ error: CustomError?) -> Void)
}

struct BaseAPI {
    
    static var APIKey: String {
        if let key = Bundle.main.infoDictionary?["API_KEY"] as? String {
            return key
        }
        print("Fail on get API key")
        return ""
    }
    
    static var APIHash: String {
        if let hash = Bundle.main.infoDictionary?["API_HASH"] as? String {
            return hash
        }
        print("Fail on get API hash")
        return ""
    }
    
    private var base = "https://gateway.marvel.com/v1/public/"
    
    var characters: String {
        return base + "characters"
    }
}
