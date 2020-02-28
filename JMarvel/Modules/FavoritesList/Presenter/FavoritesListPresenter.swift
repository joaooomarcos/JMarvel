//
//  FavoritesListPresenter.swift
//  JMarvel
//
//  Created Joao Marcos Ribeiro Araujo on 21/02/2020.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

// MARK: - Presenter Input Declaration

protocol FavoritesListPresenterInputProtocol: class {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillTransition(size: CGSize)
    func didSelect(index: IndexPath)
}

// MARK: - Presenter Output Declaration

protocol FavoritesListPresenterOutputProtocol: class {
    func setupCollectionView()
    func setupNavigationBar()
    func setupLayout()
    func didCalculate(itemSize: CGSize, spacing: CGFloat)
    func reloadCollectionLayout()
    func didGetList(_ objects: [CharacterRealm])
    func showEmptyState(_ message: String)
}

// MARK: - Presenter

class FavoritesListPresenter {

    // MARK: - Viper

    weak var view: FavoritesListPresenterOutputProtocol?
    var interactor: FavoritesListInteractorInputProtocol!
    var wireframe: FavoritesListWireframeProtocol!
    
    // MARK: - Variables
    
    private var models: [CharacterRealm] = []
    private var itemSize: CGSize = .zero
    private var isFetchingItems: Bool = false
}

// MARK: - Presenter Input

extension FavoritesListPresenter: FavoritesListPresenterInputProtocol {
    func viewDidLoad() {
        self.view?.setupCollectionView()
        self.view?.setupNavigationBar()
        self.view?.setupLayout()
    }
    
    func viewWillAppear() {
        self.interactor.getFavorites()
    }
    
    func viewWillTransition(size: CGSize) {
        let helper = SizeHelper()
        self.itemSize = helper.itemSize(for: size.width)
        self.view?.didCalculate(itemSize: self.itemSize, spacing: Constants.Dimensions.spacing)
    }
    
    func didSelect(index: IndexPath) {
        let item = self.models[index.row]
        self.wireframe.navigateToDetail(model: CharacterModel(realm: item))
    }
}

// MARK: - Interactor Output

extension FavoritesListPresenter: FavoritesListInteractorOutputProtocol {
    func didGetFavorites(_ list: [CharacterRealm]) {
        self.models = list
        self.view?.didGetList(list)
        
        if list.isEmpty {
            self.view?.showEmptyState("You don't have favorites yet 😏")
        }
    }
}
