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
    func getNavigation() -> UINavigationController?
    func navigateToDetail(model: CharacterModel)
}

class CharacterListWireframe {
    
    // MARK: - Constants
    
    private let storyboardName = "Main"
    private let storyboardID = "CharacterListView"
        
    // MARK: - Viper Properties
    
    private(set) var view: CharacterListView?

    // MARK: - Init

    private func prepareView() -> UINavigationController? {
        let view = instantiateViewController()
        
        self.view = view
        self.view?.title = "Characters list"
        
        let interactor = CharacterListInteractor()
        let presenter = CharacterListPresenter()

        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view

        view?.presenter = presenter
        interactor.output = presenter
        
        guard let controller = view else { return nil }
        
        return UINavigationController(rootViewController: controller)
    }
    
    private func instantiateViewController() -> CharacterListView? {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: storyboardID)
        return controller as? CharacterListView
    }
}

extension CharacterListWireframe: CharacterListWireframeProtocol {
    func getNavigation() -> UINavigationController? {
        self.prepareView()
    }
    
    func navigateToDetail(model: CharacterModel) {
        let detailsVC = CharacterDetailsWireframe()
        guard let navigation = self.view?.navigationController else { return }
        detailsVC.show(with: model, from: navigation)
    }
}
