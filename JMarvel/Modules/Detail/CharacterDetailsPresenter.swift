//
//  CharacterDetailsPresenter.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Presenter Input Protocol

protocol CharacterDetailsPresenterInputProtocol: class {
    func loadData()
}

// MARK: - Presenter Output Protocol

protocol CharacterDetailsPresenterOutputProtocol: class {
    func didGet(imageURL: URL?, description: String)
    func didGet(series items: [CharacterModel])
    func didGet(comics items: [CharacterModel])
}

class CharacterDetailsPresenter {
    
    // MARK: - Variables
    
    private var model: CharacterModel
    private var comics: [CharacterModel] = []
    private var series: [CharacterModel] = []
    
    // MARK: - Viper
    
    weak var view: CharacterDetailsPresenterOutputProtocol!
    var interactor: CharacterDetailsInteractorInputProtocol!
    var wireframe: CharacterDetailsWireframeProtocol!
    
    // MARK: - Init
    
    init(_ model: CharacterModel) {
        self.model = model
    }
    
    // MARK: - Data
    
    private func loadSeries() {
        guard (self.model.series?.available ?? 0) > 0 else { return }
        
        self.interactor.getSeries(with: self.model.id)
    }
}

extension CharacterDetailsPresenter: CharacterDetailsPresenterInputProtocol {
    func loadData() {
        self.loadSeries()
        self.view.didGet(imageURL: self.model.image?.image(kind: .landscape), description: self.model.description ?? "")
    }
}

extension CharacterDetailsPresenter: CharacterDetailsInteractorOutputProtocol {
    func didGet(series page: Page<CharacterModel>) {
        guard let results = page.results else {
            return
        }
        
        print(results)
        
        self.series = results
        self.view.didGet(series: series)
    }
    
    func didGet(comics page: Page<CharacterModel>) {
        
    }
    
    func didFailed(_ error: GenericError) {
        
    }
}
