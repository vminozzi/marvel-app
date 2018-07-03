//
//  SharedPresenter.swift
//  Marvel
//
//  Created by Vinicius on 30/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    // MARK: - Attributes
    private var cache = NSCache<NSString, UIImage>()
    weak var feedbackDelegate: Feedback?
    
    // MARK: - Init
    init() { }
    
    init(feedbackDelegate: Feedback) {
        self.feedbackDelegate = feedbackDelegate
    }
    
    // MARK: - Image cache
    func getImage(string: String?) -> UIImage? {
        guard let imageString = string else {
            return nil
        }
        
        if let imageCached = cache.object(forKey: NSString(string: imageString)) {
            return imageCached
        }
        
        let placeholder = UIImage(named: "placeholder-icon")
        cache.setObject(placeholder ?? UIImage(), forKey: NSString(string: imageString))
        
        if let url = URL(string: imageString) {
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: NSString(string: imageString))
                    self.feedbackDelegate?.didLoadImage(identifier: imageString)
                }
            }).resume()
        }
        return nil
    }
    
    func imageFromCache(identifier: String) -> UIImage? {
        return cache.object(forKey: NSString(string: identifier))
    }
}
