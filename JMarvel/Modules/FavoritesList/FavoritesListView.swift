//
//  FavoritesListView.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import RealmSwift
import UIKit

class FavoritesListView: JMCollectionViewController {

    // MARK: - Presenter

    var presenter: FavoritesListPresenterInputProtocol!
    
    // MARK: - Constants
    
    private let spacing: CGFloat = 16.0
    private let minItemSize = CGSize(width: 200, height: 225)
    
    // MARK: - Variables
    
    private var models: [CharacterRealm] = []
    private var itemSize = CGSize.zero

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupNavigationBar()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.loadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.calculateDimensions(width: size.width)
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARK: - Privates
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        self.collectionView.register(CharacterCell.self)
    }
    
    private func setupLayout() {
        self.view.layoutIfNeeded()
        self.calculateDimensions(width: self.view.frame.width)
    }
    
    private func calculateDimensions(width: CGFloat) {
        let utilWidth = width - 2 * self.spacing
        let itemsPerRow = round(utilWidth / self.minItemSize.width)
        
        let itemWidth = (utilWidth - ((itemsPerRow - 1) * self.spacing)) / itemsPerRow
        
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
}

// MARK: - Presenter Output

extension FavoritesListView: FavoritesListPresenterOutputProtocol {
    func didGetList(_ objects: [CharacterRealm]) {
        self.models = objects
        self.collectionView.reloadData()
        self.removeEmptyMessage()
    }
    
    func showEmptyState(_ message: String) {
        self.setEmptyMessage(message)
    }
}

// MARK: - Collection View Data Source

extension FavoritesListView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath)
        let model = models[indexPath.row]
        
        cell.setup(with: model)
        
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout

extension FavoritesListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.spacing,
                            left: self.spacing,
                            bottom: self.spacing,
                            right: self.spacing)
    }
}
