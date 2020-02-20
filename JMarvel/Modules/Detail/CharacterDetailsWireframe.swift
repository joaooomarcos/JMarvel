//
//  CharacterDetailWireframe.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol CharacterDetailsWireframeProtocol: class { }

class CharacterDetailsWireframe: CharacterDetailsWireframeProtocol {
    
    // MARK: - Viper Properties
    
    var view: CharacterDetailsViewController?
    
    // MARK: - Init
    
    init(view: CharacterDetailsViewController, model: CharacterModel) {
        self.view = view
        self.view?.title = model.name
        
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter(model)
        
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view
        
        view.presenter = presenter
        interactor.output = presenter
    }
}
