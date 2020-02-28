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
    func getDetail(with id: Int)
    func getSeries(with id: Int)
    func getComics(with id: Int)
    func updateLocal(_ model: CharacterModel)
    func verifyFavorite(with id: Int)
}

// MARK: - Interactor Output Declaration

protocol CharacterDetailsInteractorOutputProtocol: class {
    func didGet(detail page: Page<CharacterModel>)
    func didGet(series page: Page<PosterItem>)
    func didGet(comics page: Page<PosterItem>)
    func didFailed(_ error: GenericError)
    func didGetFavorite(id: Int, isFavorite: Bool)
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
    func getDetail(with id: Int) {
        self.api.getDetail(with: id) { result in
            switch result {
            case .success(let page):
                self.output?.didGet(detail: page)
            case .error(let error):
                self.output?.didFailed(error)
            }
        }
    }
    
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
        let realmObject = model.realmObject()
        if let dataBaseObject = dataBase.object(realmObject) {
            dataBase.delete(dataBaseObject)
        } else {
            dataBase.save(realmObject)
        }
    }
    
    func verifyFavorite(with id: Int) {
        let isFavorite = self.dataBase.isFavorite(id: id)
        self.output?.didGetFavorite(id: id, isFavorite: isFavorite)
    }
}
