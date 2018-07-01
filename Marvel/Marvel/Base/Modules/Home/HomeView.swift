//
//  HomeView.swift
//  Marvel
//
//  Created by Bruno Santos on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit

class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, Feedback, CharacterFavoriteDelegate {
    
    // MARK: - Attributes
    lazy var presenter: HomePresenterProtocol = HomePresenter(view: self)
    private let pullToRefresh = UIRefreshControl()
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let selectedIndex = tabBarController?.selectedIndex, let type = ContentType(rawValue: selectedIndex) else {
            return
        }
        presenter.contentType = type
        load()
    }
    
    // MARK: - Setup
    fileprivate func setup() {
        setupNavigationController()
        setupSearchBar()
        if presenter.contentType == .home {
            addPullToRefresh()
        }
    }
    
    fileprivate func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.tintColor = .red
        navigationItem.searchController = search
    }
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func addPullToRefresh() {
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = pullToRefresh
        } else {
            collectionView?.addSubview(pullToRefresh)
        }
        pullToRefresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        if presenter.contentType == .home {
            presenter.interactor.refresh()
        }
    }
    
    fileprivate func load() {
        showLoader()
        presenter.load()
    }
    
    // MARK: - UICollectionViewDelegate/Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharacterCell.self), for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.row == presenter.numberOfItems() - 1 && presenter.contentType == .home {
            load()
        }
        cell.favoriteDelegate = self
        cell.fill(with: presenter.getCharacterDTO(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let characterCell = cell as? CharacterCell {
            characterCell.fill(with: presenter.getCharacterDTO(index: indexPath.row))
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.width / 2) - 12), height: (view.frame.width / 2) + 80)
    }
    
    // MARK: - Feedback
    func feedback(error: String?) {
        dismissLoader()
        presenter.canLoadMore = true
        
        if let message = error {
            DispatchQueue.main.async {
                self.feedbackLabel.text = message
            }
            showDefaultAlert(message: message, completeBlock: nil)
        } else {
            if presenter.numberOfItems() == 0 {
                feedbackLabel.text = "No results"
                return
            }
        }
        
        DispatchQueue.main.async {
            self.feedbackLabel.text = ""
            self.collectionView.reloadData()
        }
    }
    
    func didLoadImage(identifier: String) {
        DispatchQueue.main.async {
            guard let collection = self.collectionView else {
                return
            }
            for cell in collection.visibleCells {
                if let characterCell = cell as? CharacterCell, characterCell.identifier == identifier {
                    let image = self.presenter.imageCache.imageFromCache(identifier: identifier)
                    characterCell.setImage(with: image)
                }
            }
        }
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        showLoader()
        presenter.searchCharacter(name: searchController.searchBar.text ?? "")
    }
    
    // MARK: - CharacterFavoriteDelegate
    func favorite(with identifier: Int) {
        presenter.interactor.favorite(character: identifier, contentType: presenter.contentType)
    }
}
