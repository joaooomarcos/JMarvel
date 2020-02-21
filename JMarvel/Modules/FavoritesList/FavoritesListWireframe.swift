//
//  FavoritesListWireframe.swift
//  JMarvel
//
//  Created Joao Marcos Ribeiro Araujo on 21/02/2020.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Wireframe Protocol Declaration

protocol FavoritesListWireframeProtocol: class {
    func getNavigation() -> UINavigationController?
    func navigateToDetail(model: CharacterModel)
}

// MARK: - Wireframe

class FavoritesListWireframe {
    
    // MARK: - Constants
    
    private let storyboardName = "Main"
    private let storyboardID = "FavoritesListView"
    
    // MARK: - View

    private(set) weak var view: FavoritesListView?

	// MARK: - Private

    private func prepareView() -> UINavigationController? {
        let view = self.instantiateViewController()
        
        self.view = view
        self.view?.title = "Favorites"
        
        let interactor = FavoritesListInteractor()
        let presenter = FavoritesListPresenter()
        
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view
        
        view?.presenter = presenter
        interactor.output = presenter
        
        guard let controller = view else { return nil }
        
        return UINavigationController(rootViewController: controller)
    }
    
    private func instantiateViewController() -> FavoritesListView? {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: storyboardID)
        return controller as? FavoritesListView
    }
}

// MARK: - Wireframe Protocol

extension FavoritesListWireframe: FavoritesListWireframeProtocol {
    func getNavigation() -> UINavigationController? {
        self.prepareView()
    }
    
    func navigateToDetail(model: CharacterModel) {
        let detailsVC = CharacterDetailsWireframe()
        guard let navigation = self.view?.navigationController else { return }
        detailsVC.show(with: model, from: navigation)
    }
}
