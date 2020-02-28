//
//  FavoritesListInteractor.swift
//  JMarvel
//
//  Created Joao Marcos Ribeiro Araujo on 21/02/2020.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import Realm

// MARK: - Interactor Input Declaration

protocol FavoritesListInteractorInputProtocol: class {
    func getFavorites()
}

// MARK: - Interactor Output Declaration

protocol FavoritesListInteractorOutputProtocol: class {
    func didGetFavorites(_ list: [CharacterRealm])
}

// MARK: - Interactor

class FavoritesListInteractor {

    // MARK: - Output

    weak var output: FavoritesListInteractorOutputProtocol?

    // MARK: - Variables
    
    private var dataBase: LocalDatabaseManager

    // MARK: - Inits

    init(dataBase: LocalDatabaseManager = LocalDatabaseManager()) {
        self.dataBase = dataBase
    }
}

// MARK: - Interactor Input

extension FavoritesListInteractor: FavoritesListInteractorInputProtocol {
    func getFavorites() {
        let results = dataBase.objects(CharacterRealm.self)
        self.output?.didGetFavorites(results)
    }
}
