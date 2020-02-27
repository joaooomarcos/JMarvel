//
//  WidgetInteractor.swift
//  JMarvelWidget
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import Realm

// MARK: - Interactor Input Declaration

protocol WidgetInteractorInputProtocol: class {
    func getFavorites(limit: Int)
}

// MARK: - Interactor Output Declaration

protocol WidgetInteractorOutputProtocol: class {
    func didGetFavorites(_ list: [CharacterRealm])
}

// MARK: - Interactor

class WidgetInteractor {

    // MARK: - Output

    weak var output: WidgetInteractorOutputProtocol?

    // MARK: - Variables
    
    private var dataBase: LocalDatabaseManager

    // MARK: - Inits

    init(dataBase: LocalDatabaseManager = LocalDatabaseManager()) {
        self.dataBase = dataBase
    }
}

// MARK: - Interactor Input

extension WidgetInteractor: WidgetInteractorInputProtocol {
    func getFavorites(limit: Int) {
        // TODO: LIMIT
        let results = dataBase.objects(CharacterRealm.self)
        self.output?.didGetFavorites(results)
    }
}
