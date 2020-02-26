//
//  CharacterListView.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class CharacterListView: UICollectionViewController {
    
    // MARK: - Presenter
    
    var presenter: CharacterListPresenterInputProtocol!
    
    // MARK: - Constants
    
    private static let spacing: CGFloat = 16.0
    private static let minItemSize = CGSize(width: 200, height: 225)
    
    // MARK: - Variables
    
    private var models: [CharacterModel] = []
    private var itemSize = CGSize.zero
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupNavigationBar()
        self.setupSearch()
        self.setupLayout()
        self.presenter.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.refreshData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.calculateDimensions(width: size.width)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Privates
    
    private func setupCollectionView() {
        self.collectionView.register(CharacterCell.self)
        self.collectionView.refreshControl = self.refreshControl
        self.collectionView.prefetchDataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = UIColor(named: "main")
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self.presenter as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
    
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
    
    private func setupLayout() {
        self.view.layoutIfNeeded()
        self.calculateDimensions(width: self.view.frame.width)
    }
    
    private func calculateDimensions(width: CGFloat) {
        let utilWidth = width - 2 * CharacterListView.spacing
        let itemsPerRow = round(utilWidth / CharacterListView.minItemSize.width)
        
        let itemWidth = (utilWidth - ((itemsPerRow - 1) * CharacterListView.spacing)) / itemsPerRow
        
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    @objc
    private func refreshData() {
        self.refreshControl.beginRefreshing()
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

// MARK: - Collection View Delegate Flow Layout

extension CharacterListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterListView.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterListView.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CharacterListView.spacing,
                            left: CharacterListView.spacing,
                            bottom: CharacterListView.spacing,
                            right: CharacterListView.spacing)
    }
}

// MARK: - Presenter Output

extension CharacterListView: CharacterListPresenterOutputProtocol {
    func didGet(_ characters: [CharacterModel]) {
        self.models = characters
        self.collectionView.reloadData()
    }
    
    func didFail(_ message: String) {
        print("Error: \(message)")
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
