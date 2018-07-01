//
//  CharactersRequest.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 28/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class CharactersRequest: Requestable {
    
    // MARK: - Attributes
    private let offset: Int
    private let name: String
    
    init(offset: Int = 0, name: String = "") {
        self.offset = offset
        self.name = name
    }
    
    // MARK: - Request
    func request(completion: @escaping (CharactersData?, RequestError?) -> Void) {
        var parameters = [URLQueryItem]()
        if name.isEmpty {
            parameters = [URLQueryItem(name: "offset", value: "\(offset)")]
        } else {
            parameters = [URLQueryItem(name: "nameStartsWith", value: name)]
        }
        APIClient().request(type: CharactersResult.self, urlString: BaseAPI().characters, parameters: parameters) { result, error in
            completion(result?.data, error)
        }
    }
}
