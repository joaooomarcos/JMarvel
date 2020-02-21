//
//  CharacterDetailWireframe.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Wireframe Protocol Declaration

protocol CharacterDetailsWireframeProtocol: class {
    func show(with model: CharacterModel, from navigation: UINavigationController)
}

// MARK: - Wireframe

class CharacterDetailsWireframe {
    
    // MARK: - View

    private(set) weak var view: CharacterDetailsViewController?
    
    // MARK: - Constants
    
    private let storyBoardName = "Main"
    private let storyBoardID = "CharacterDetailsViewController"
    
    // MARK: - Private
    
    private func prepareView(model: CharacterModel) -> CharacterDetailsViewController? {
        let storyBoard = UIStoryboard(name: self.storyBoardName, bundle: nil)
        let uiViewController = storyBoard.instantiateViewController(identifier: self.storyBoardID)
        guard let viewController = uiViewController as? CharacterDetailsViewController else { return nil }
        
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter(model)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = viewController
        interactor.output = presenter
        viewController.title = model.name
        
        self.view = viewController
        
        return view
    }
}

// MARK: - Wireframe Protocol

extension CharacterDetailsWireframe: CharacterDetailsWireframeProtocol {
    func show(with model: CharacterModel, from navigation: UINavigationController) {
        guard let view = self.prepareView(model: model) else { return }
        navigation.show(view, sender: nil)
    }
}
