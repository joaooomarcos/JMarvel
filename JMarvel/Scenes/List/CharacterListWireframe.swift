//
//  CharacterListWireframe.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol CharacterListWireframeProtocol: class { }

class CharacterListWireframe: CharacterListWireframeProtocol {
        
    // MARK: - Viper Module Properties
    
    var view: CharacterListViewController?

    // MARK: - Init

    init(view: CharacterListViewController) {
        self.view = view
        self.view?.title = "Characters list"
        
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()

        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view

        view.presenter = presenter
        interactor.output = presenter
    }
}
