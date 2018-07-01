//
//  DetailView.swift
//  Marvel
//
//  Created by Vinicius on 01/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UITableViewController, Feedback {
    
    lazy var presenter: DetailPresenterProtocol = DetailPresenter(view: self)
    var characterDTO = DetailCharacterDTO() {
        didSet {
            if UIDevice.current.userInterfaceIdiom == .pad {
                load()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    // MARK: - Load
    func load() {
        title = characterDTO.name
        presenter.loadContent(character: characterDTO)
    }
    
    // MARK: - TableViewDelegate/DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = DetailCellType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch type {
        case .thumbnail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterThumbnailCell.self), for: indexPath) as? CharacterThumbnailCell else {
                return UITableViewCell()
            }
            cell.fill(with: presenter.getThumbnailCellDTO())
            return cell
            
        case .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterDescriptionCell.self), for: indexPath) as? CharacterDescriptionCell else {
                return UITableViewCell()
            }
            cell.fill(with: presenter.getDescriptionCellDTO())
            return cell
            
        case .series:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterSeriesComicsCell.self), for: indexPath) as? CharacterSeriesComicsCell else {
                return UITableViewCell()
            }
            cell.fill(with: presenter.getSeriesCellDTO())
            return cell
            
        case .comics:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterSeriesComicsCell.self), for: indexPath) as? CharacterSeriesComicsCell else {
                return UITableViewCell()
            }
            cell.fill(with: presenter.getComicsCellDTO())
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let type = DetailCellType(rawValue: indexPath.section) else {
            return UITableViewAutomaticDimension
        }
        switch type {
        case .thumbnail:
            return (view.frame.height / 2)
        case .description:
            return UITableViewAutomaticDimension
        case .comics, .series:
            return 150.0
        }
    }
    
    // MARK: - Feedback
    func feedback(error: String?) {
        //
    }
    
    func didLoadImage(identifier: String) {
        //
    }
}
