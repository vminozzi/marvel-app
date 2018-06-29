//
//  CharactersRequest.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 28/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class CharactersRequest: Requestable {
    
    // MARK: - Request
    func request(completion: @escaping (CharactersResponse?, CustomError?) -> Void) {
        APIClient().request(type: CharactersResponse.self, urlString: BaseAPI().characters) { response, error in
            //
        }
    }
}
