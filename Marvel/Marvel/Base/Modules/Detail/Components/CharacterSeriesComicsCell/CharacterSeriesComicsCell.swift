//
//  CharacterSeriesComicsCell.swift
//  Marvel
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class CharacterSeriesComicsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Attributes
    var items = [Item]()
    lazy var presenter: CharacterSeriesComicsCellPresenterProtocol = CharacterSeriesComicsCellPresenter()
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Awake
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self        
    }
    
    // MARK: - Instance methods
    func fill(with data: CharacterSeriesComicsDTO) {
        items = data.items
        presenter.load(with: items)
        self.collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDelegate/UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterSeriesComicsCollectionCell.self), for: indexPath) as?
            CharacterSeriesComicsCollectionCell else {
                return UICollectionViewCell()
        }
        cell.fill(with: presenter.getCollectionCellDTO(at: indexPath.row))
        return cell
    }
}
