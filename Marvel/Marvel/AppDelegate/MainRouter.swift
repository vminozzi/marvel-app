//
//  MainRouter.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class MainRouter {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func launch() {
        window.rootViewController = home()
        window.makeKeyAndVisible()
    }
    
    private func home() -> UIViewController {
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")
    }
}
