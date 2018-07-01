//
//  HomeRouter.swift
//  Marvel
//
//  Created by Bruno Santos on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func launch() {
        window.rootViewController = home()
        window.makeKeyAndVisible()
    }
    
    func goToDetail() {
        
    }
    
    private func home() -> UIViewController {
        return UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController")
    }
    
    private func detail() -> UIViewController {
        return UIViewController()
    }
}
