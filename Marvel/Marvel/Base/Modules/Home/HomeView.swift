//
//  HomeView.swift
//  Marvel
//
//  Created by Vinicius Minozzi on 29/06/18.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import UIKit

class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, Feedback, CharacterFavoriteDelegate, HomeRouterProtocol {
    
    // MARK: - Attributes
    fileprivate let search = UISearchController(searchResultsController: nil)
    lazy var presenter: HomePresenterProtocol = HomePresenter(view: self, routerProtocol: self)
    private let pullToRefresh = UIRefreshControl()
    var splitDetailView: SplitViewController? {
        guard let splitViewController = splitViewController as? SplitViewController else {
            return SplitViewController()
        }
        return splitViewController
    }
    
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
        
        if presenter.contentType == .home {
            self.title = "Marvel"
            addPullToRefresh()
        } else {
            self.title = "Favorites"
            collectionView.refreshControl = nil
        }
    }
    
    // MARK: - Setup
    fileprivate func setup() {
        setupNavigationController()
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        search.searchBar.delegate = self
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.tintColor = .red
        search.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = search
    }
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        extendedLayoutIncludesOpaqueBars = true
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
            presenter.refresh()
        }
    }
    
    internal func load() {
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
            presenter.loadMore()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)

    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((view.frame.width / 2) - 12), height: (view.frame.width / 2) + 80)
    }
    
    // MARK: - Feedback
    func feedback(error: String?) {
        dismissLoader()
        presenter.canLoadMore = true
        
        DispatchQueue.main.async {
            if let message = error {
                self.pullToRefresh.endRefreshing()
                self.feedbackLabel.text = message
                self.showDefaultAlert(message: message, completeBlock: nil)
            } else {
                self.feedbackLabel.text = self.presenter.numberOfItems() == 0 ? "No results" : ""
            }
            self.pullToRefresh.endRefreshing()
            self.collectionView.reloadData()
        }
    }

    func didLoadImage(identifier: String) {
        guard let collection = self.collectionView else {
            return
        }
        DispatchQueue.main.async {
            for cell in collection.visibleCells {
                if let characterCell = cell as? CharacterCell, characterCell.identifier == identifier {
                    let image = self.presenter.imageCache.imageFromCache(identifier: identifier)
                    characterCell.setImage(with: image)
                }
            }
        }
    }
    
    // MARK: - UISearchResultsUpdating
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        showLoader()
        presenter.searchCharacter(name: searchText)
    }
    
    // MARK: - CharacterFavoriteDelegate
    func favorite(with identifier: Int) {
        presenter.didFavorite(characterId: identifier)
    }
}
