//
//  TodayViewController.swift
//  Widget
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,Feedback {
    
    // MARK: - Attributes
    lazy var presenter: TodayPresenterProtocol = TodayPresenter(view: self)
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }

    // MARK: - Feedback
    func didLoad() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - UICollectionViewDelegate/UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterWidgetCell.self), for: indexPath) as? CharacterWidgetCell else {
            return UICollectionViewCell()
        }
        cell.fill(with: presenter.getCharacterDTO(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        launch()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3) - 16, height: view.frame.height)
    }
    
    // MARK: - Launch
    func launch() {
        if let url = URL(string: "marvel-app://d/") {
            extensionContext?.open(url, completionHandler: nil)
        }
    }
}
