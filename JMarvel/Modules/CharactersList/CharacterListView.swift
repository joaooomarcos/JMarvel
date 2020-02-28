//
//  CharacterListView.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class CharacterListView: JMCollectionViewController {
    
    // MARK: - Presenter
    
    var presenter: CharacterListPresenterInputProtocol!
    
    // MARK: - Variables
    
    private var models: [CharacterModel] = []
    
    private let refreshControl = UIRefreshControl()
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.presenter.viewWillTransition(size: size)
    }
    
    @objc
    private func refreshData() {
        self.presenter.refreshData()
    }
}

// MARK: - Collection View Data Source

extension CharacterListView: UICollectionViewDataSourcePrefetching {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath)
        let model = models[indexPath.row]
        
        cell.setup(with: model, delegate: self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        self.presenter.loadMore(for: indexPaths)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelectItem(indexPath: indexPath)
    }
}

// MARK: - Presenter Output

extension CharacterListView: CharacterListPresenterOutputProtocol {
    
    func setupCollectionView() {
        self.collectionView.register(CharacterCell.self)
        self.collectionView.refreshControl = self.refreshControl
        self.collectionView.prefetchDataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "main")
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self.presenter as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
    
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
    
    func setupLayout() {
        self.view.layoutIfNeeded()
        self.presenter.viewWillTransition(size: self.view?.frame.size ?? .zero)
    }
    
    func didCalculate(itemSize: CGSize, spacing: CGFloat) {
        self.itemSize = itemSize
        self.itemSpacing = spacing
    }
    
    func reloadCollectionLayout() {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func didGet(_ characters: [CharacterModel]) {
        self.models = characters
        self.collectionView.reloadData()
        self.removeEmptyMessage()
    }
    
    func showAlert(title: String, message: String) {
        self.showSimpleAlert(title: title, message: message)
    }
    
    func showEmptyState(message: String) {
        self.setEmptyMessage(message)
    }
    
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
        self.refreshControl.endRefreshing()
    }
}

extension CharacterListView: CharacterCellActionDelegate {
    func didTapFavorite(_ model: CharacterModel) {
        self.presenter.didTapFavorite(on: model)
    }
}
