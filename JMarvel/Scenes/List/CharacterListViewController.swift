//
//  CharacterListViewController.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    // MARK: - Presenter
    
    var presenter: CharacterListPresenterInputProtocol!
    
    // MARK: - Constants
    
    private static let spacing: CGFloat = 16.0
    private static let minItemSize = CGSize(width: 200, height: 225)
    
    // MARK: - Variables
    
    private var models: [CharacterListItem] = []
    private var itemSize = CGSize.zero
    private lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupNavigationBar()
        self.setupSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.loadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.calculateDimensions(width: size.width)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Layout
    
    private func setupCollectionView() {
        self.collectionView.register(CharacterCell.self)
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
    
    private func calculateDimensions(width: CGFloat) {
        let utilWidth = width - 2 * CharacterListViewController.spacing
        let itemsPerRow = round(utilWidth / CharacterListViewController.minItemSize.width)
        
        let itemWidth = (utilWidth - ((itemsPerRow - 1) * CharacterListViewController.spacing)) / itemsPerRow
        
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
}

// MARK: - Collection View Data Source

extension CharacterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath)
        let model = models[indexPath.row]
        
        cell.setup(with: model)
        
        return cell
    }    
}

// MARK: - Collection View Delegate Flow Layout

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterListViewController.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CharacterListViewController.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CharacterListViewController.spacing,
                            left: CharacterListViewController.spacing,
                            bottom: CharacterListViewController.spacing,
                            right: CharacterListViewController.spacing)
    }
}

// MARK: - Presenter Output

extension CharacterListViewController: CharacterListPresenterOutputProtocol {
    func didGet(_ characters: [CharacterListItem]) {
        self.models = characters
        self.collectionView.reloadData()
    }
    
    func didFail(_ message: String) {
        print("Error: \(message)")
    }
}
