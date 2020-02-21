//
//  CharacterDetailInteractor.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Interactor Input

protocol CharacterDetailsInteractorInputProtocol {
    func getSeries(with id: Int)
    func getComics(with id: Int)
}

// MARK: - Interactor Output

protocol CharacterDetailsInteractorOutputProtocol: class {
    func didGet(series page: Page<PosterItem>)
    func didGet(comics page: Page<PosterItem>)
    func didFailed(_ error: GenericError)
}

class CharacterDetailsInteractor {
    
    // MARK: - Output
    
    weak var output: CharacterDetailsInteractorOutputProtocol?
    
    // MARK: - Variables
    
    private var api: CharacterDetailsAPI
    
    // MARK: - Init
    
    init(api: CharacterDetailsAPI = CharacterDetailsAPI()) {
        self.api = api
    }
}

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
}
