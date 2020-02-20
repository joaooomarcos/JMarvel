//
//  CharacterListInteractor.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Interactor Input

protocol CharacterListInteractorInputProtocol {
    func getCharacters(with offset: Int)
}

// MARK: - Interactor Output

protocol CharacterListInteractorOutputProtocol: class {
    func didGet(_ page: Page<CharacterModel>)
    func didFailed(_ error: GenericError)
}

class CharacterListInteractor {
    
    // MARK: - Output
    
    weak var output: CharacterListInteractorOutputProtocol?
    
    // MARK: - Variables
    
    private var api: CharacterAPI
    
    // MARK: - Init
    
    init(api: CharacterAPI = CharacterAPI()) {
        self.api = api
    }
}

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
}
