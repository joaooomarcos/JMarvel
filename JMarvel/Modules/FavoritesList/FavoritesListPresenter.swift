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
}

// MARK: - Presenter Output Declaration

protocol FavoritesListPresenterOutputProtocol: class {
    func didGetList(_ objects: [CharacterRealm])
}

// MARK: - Presenter

class FavoritesListPresenter {

    // MARK: - Viper

    weak var view: FavoritesListPresenterOutputProtocol?
    var interactor: FavoritesListInteractorInputProtocol!
    var wireframe: FavoritesListWireframeProtocol!
}

// MARK: - Presenter Input

extension FavoritesListPresenter: FavoritesListPresenterInputProtocol {
    func loadData() {
        self.interactor.getFavorites()
    }
}

// MARK: - Interactor Output

extension FavoritesListPresenter: FavoritesListInteractorOutputProtocol {
    func didGetFavorites(_ list: [CharacterRealm]) {
        self.view?.didGetList(list)
    }
}
