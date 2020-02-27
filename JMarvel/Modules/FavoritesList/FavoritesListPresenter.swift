//
//  FavoritesListPresenter.swift
//  JMarvel
//
//  Created Joao Marcos Ribeiro Araujo on 21/02/2020.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Presenter Input Declaration

protocol FavoritesListPresenterInputProtocol: class {
    func loadData()
    func didSelect(index: IndexPath)
}

// MARK: - Presenter Output Declaration

protocol FavoritesListPresenterOutputProtocol: class {
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
}

// MARK: - Presenter Input

extension FavoritesListPresenter: FavoritesListPresenterInputProtocol {
    func didSelect(index: IndexPath) {
        let item = self.models[index.row]
        self.wireframe.navigateToDetail(model: CharacterModel(realm: item))
    }
    
    func loadData() {
        self.interactor.getFavorites()
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
