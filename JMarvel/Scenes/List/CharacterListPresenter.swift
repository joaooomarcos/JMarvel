//
//  CharacterListPresenter.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Presenter Input Protocol

protocol CharacterListPresenterInputProtocol: class {
    func loadData()
}

// MARK: - Presenter Output Protocol

protocol CharacterListPresenterOutputProtocol: class {
    func didGet(_ characters: [CharacterListItem])
    func didFail(_ message: String)
}

class CharacterListPresenter {
    
    // MARK: - Viper 
    
    weak var view: CharacterListPresenterOutputProtocol!
    var interactor: CharacterListInteractorInputProtocol!
    var wireframe: CharacterListWireframeProtocol!
}

// MARK: - HomePresenterInputProtocol

extension CharacterListPresenter: CharacterListPresenterInputProtocol {
    func loadData() {
        self.interactor.getCharacters()
    }
}

// MARK: - HomePresenterInteractorOutputProtocol

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    func didGet(_ page: Page<CharacterModel>) {
        guard let results = page.results else {
            self.view.didFail("")
            return
        }
        
        let models: [CharacterListItem] = results.compactMap({ CharacterListItem($0) })
        self.view.didGet(models)
    }
    
    func didFailed(_ error: GenericError) {
        self.view.didFail(error.message)
    }
}
