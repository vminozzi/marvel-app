//
//  SplitViewController.swift
//  Marvel
//
//  Created by Vinicius on 30/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate, DetailViewDegelgate {
    
    var detailView: UIViewController? {
        return viewControllers.last
    }
    
    var homeView: UIViewController? {
        return viewControllers.first
    }
    
    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func showDetailViewController(dto: DetailCharacterDTO) {
        if let navigationViewController = detailView as? UINavigationController, let detailView = navigationViewController.topViewController as? DetailView {
            detailView.characterDTO = dto
            detailView.delegate = self
            showDetailViewController(navigationViewController, sender: nil)
        }
    }
    
    func reloadFavorite(characterId: Int) {
        if let navigationViewController = detailView as? UINavigationController, let detailView = navigationViewController.topViewController as? DetailView {
            detailView.reloadFavorite(characterId: characterId)
        }
    }
    
    // MARK: - DetailViewDegelgate
    func didReload() {
        if let navigationViewController = homeView as? UINavigationController, let homeView = navigationViewController.topViewController as? HomeView {
            homeView.load()
        }
    }
}
