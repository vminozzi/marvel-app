//
//  APIClient.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 28/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

enum ErrorType: String {
    case urlComponents = "Invalid Parameters"
    case deserealize = "Invalid object"
    case fromAPI = "Server error"
}

struct RequestError {
 
    let type: ErrorType
    let message: String
    
    init(type: ErrorType = .fromAPI, error: Error? = nil) {
        self.type = type
        if let error = error {
            message = error.localizedDescription
        } else {
            message = self.type.rawValue
        }
    }
}

class APIClient {
    
    let ts = "1530217670"
    
    func request<T: Mappable>(type: T.Type, urlString: String, parameters: [URLQueryItem]? = nil, completion: @escaping (T?, RequestError?) -> Void) {
        
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: BaseAPI.APIKey),
                                     URLQueryItem(name: "hash", value: BaseAPI.APIHash),
                                     URLQueryItem(name: "ts", value: ts),
                                     URLQueryItem(name: "orderBy", value: "name")]
        
        if let parameters = parameters {
            urlComponents?.queryItems?.append(contentsOf: parameters)
        }
        
        guard let url = urlComponents?.url else {
            completion(nil, RequestError(type: .urlComponents))
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            let result = self.handlerResponse(data: data, handle: (type: T.self, error: error))
            completion(result.model, result.error)
            }.resume()
    }
    
    private func handlerResponse <T: Mappable>(data: Data?, handle: (type: T.Type, error: Error?)) -> (model: T?, error: RequestError?) {
        
        if let _ = handle.error {
            return (nil, RequestError(error: handle.error))
        }
        
        guard let data = data, let model = T(data: data) else {
            return (nil, RequestError(type: .deserealize))
        }
        
        return (model, nil)
    }
}
