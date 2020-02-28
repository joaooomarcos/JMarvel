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
        
    // MARK: - Variables
    
    private var models: [CharacterRealm] = []

    // MARK: - Lifecycle

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
}

// MARK: - Presenter Output

extension FavoritesListView: FavoritesListPresenterOutputProtocol {
    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupCollectionView() {
        self.collectionView.register(CharacterCell.self)
    }
    
    func setupLayout() {
        self.view.layoutIfNeeded()
        self.presenter.viewWillTransition(size: self.view.frame.size)
    }
    
    func didCalculate(itemSize: CGSize, spacing: CGFloat) {
        self.itemSize = itemSize
        self.itemSpacing = spacing
    }
    
    func reloadCollectionLayout() {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.didSelect(index: indexPath)
    }
}
