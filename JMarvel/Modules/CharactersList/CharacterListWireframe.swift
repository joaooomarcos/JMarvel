//
//  CharacterListWireframe.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol CharacterListWireframeProtocol: class {
    func navigateToDetail(model: CharacterModel)
}

class CharacterListWireframe {
        
    // MARK: - Viper Properties
    
    var view: CharacterListView?

    // MARK: - Init

    init(view: CharacterListView) {
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

extension CharacterListWireframe: CharacterListWireframeProtocol {
    func navigateToDetail(model: CharacterModel) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let controller = storyBoard.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as? CharacterDetailsViewController {
            let charactersWire = CharacterDetailsWireframe(view: controller, model: model)
            if let destination = charactersWire.view {
                self.view?.navigationController?.pushViewController(destination, animated: true)
            }
        }
    }
}
