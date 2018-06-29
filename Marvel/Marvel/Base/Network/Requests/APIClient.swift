//
//  APIClient.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 28/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class APIClient {
    
    let ts = "1530217670"
    
    func request<T: Mappable>(type: T, urlString: String, parameters: [URLQueryItem]? = nil, completion: @escaping (T?, CustomError?) -> Void) {
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: BaseAPI.APIKey),
                                     URLQueryItem(name: "hash", value: BaseAPI.APIHash),
                                     URLQueryItem(name: "ts", value: ts)]
        
        if let parameters = parameters {
            urlComponents?.queryItems?.append(contentsOf: parameters)
        }
        
        guard let url = urlComponents?.url else {
            completion(nil, CustomError())
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            let result = self.handlerResponse(data: data, handle: (type: T.self, error: error))
            completion(result.model, result.error)
            }.resume()
    }
    
    func handlerResponse <T: Mappable>(data: Data?, handle: (type: T.Type, error: Error?)) -> (model: T?, error: CustomError?) {
        
        if let error = handle.error {
            return (nil, CustomError(error: error))
        }
        
        guard let data = data, let model = T(data: data) else {
            return (nil, CustomError(error: handle.error))
        }
        
        return (model, nil)
    }
}
