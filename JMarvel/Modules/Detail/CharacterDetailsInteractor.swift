//
//  CharacterDetailInteractor.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Interactor Input Declaration

protocol CharacterDetailsInteractorInputProtocol: class {
    func getSeries(with id: Int)
    func getComics(with id: Int)
    func updateLocal(_ model: CharacterModel)
}

// MARK: - Interactor Output Declaration

protocol CharacterDetailsInteractorOutputProtocol: class {
    func didGet(series page: Page<PosterItem>)
    func didGet(comics page: Page<PosterItem>)
    func didFailed(_ error: GenericError)
}

// MARK: - Interactor

class CharacterDetailsInteractor {
    
    // MARK: - Output
    
    weak var output: CharacterDetailsInteractorOutputProtocol?
    
    // MARK: - Variables
    
    private var api: CharacterDetailsAPI
    private var dataBase: LocalDatabaseManager
    
    // MARK: - Init
    
    init(api: CharacterDetailsAPI = CharacterDetailsAPI(), dataBase: LocalDatabaseManager = LocalDatabaseManager()) {
        self.api = api
        self.dataBase = dataBase
    }
}

// MARK: - Interactor Input

extension CharacterDetailsInteractor: CharacterDetailsInteractorInputProtocol {
    func getSeries(with id: Int) {
        self.api.getSeries(with: id, completion: { result in
            switch result {
            case .success(let page):
                self.output?.didGet(series: page)
            case .error(let error):
                self.output?.didFailed(error)
            }
        })
    }
    
    func getComics(with id: Int) {
        self.api.getComics(with: id, completion: { result in
            switch result {
            case .success(let page):
                self.output?.didGet(comics: page)
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
}
