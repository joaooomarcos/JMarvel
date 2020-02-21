//
//  CharacterListInteractor.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Interactor Input Declaration

protocol CharacterListInteractorInputProtocol: class {
    func getCharacters(with offset: Int)
    func updateLocal(_ model: CharacterModel)
    func getFavorites()
}

// MARK: - Interactor Output Declaration

protocol CharacterListInteractorOutputProtocol: class {
    func didGet(_ page: Page<CharacterModel>)
    func didFailed(_ error: GenericError)
    func didGetIdFavoritesList(_ ids: [Int])
}

// MARK: - Interactor

class CharacterListInteractor {
    
    // MARK: - Output
    
    weak var output: CharacterListInteractorOutputProtocol?
    
    // MARK: - Variables
    
    private var api: CharacterAPI
    private var dataBase: LocalDatabaseManager
    
    // MARK: - Init
    
    init(api: CharacterAPI = CharacterAPI(), dataBase: LocalDatabaseManager = LocalDatabaseManager()) {
        self.api = api
        self.dataBase = dataBase
    }
}

// MARK: - Interactor Input

extension CharacterListInteractor: CharacterListInteractorInputProtocol {
    func getCharacters(with offset: Int) {
        self.api.getList(with: offset, completion: { result in
            switch result {
            case .success(let page):
                self.output?.didGet(page)
            case .error(let error):
                self.output?.didFailed(error)
            }
        })
    }
    
    func updateLocal(_ model: CharacterModel) {
        let realmObject = CharacterRealm(model)
        if let dataBaseObject = dataBase.object(realmObject) {
            dataBase.delete(dataBaseObject)
        } else {
            dataBase.save(realmObject)
        }
    }
    
    func getFavorites() {
        let results = dataBase.objects(CharacterRealm.self)
        let ids: [Int] = results.compactMap { $0.id }
        self.output?.didGetIdFavoritesList(ids)
    }
}
