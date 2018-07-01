//
//  Array+Extension.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 28/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit

extension Array {
    func element(at index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}
