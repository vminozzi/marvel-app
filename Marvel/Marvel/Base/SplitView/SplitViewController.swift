//
//  SplitViewController.swift
//  Marvel
//
//  Created by Vinicius on 30/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    var detailViewController: UIViewController? {
        return viewControllers.last
    }
    
    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func showDetailViewController(dto: DetailCharacterDTO) {
        if let navigationViewController = detailViewController as? UINavigationController, let detailViewController = navigationViewController.topViewController as? DetailView {
            detailViewController.characterDTO = dto
            showDetailViewController(navigationViewController, sender: nil)
        }
    }
}
