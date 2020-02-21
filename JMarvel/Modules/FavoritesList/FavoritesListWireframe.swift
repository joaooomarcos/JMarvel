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
    func showFavoritesList(from tabBarController: UITabBarController)
}

// MARK: - Wireframe

class FavoritesListWireframe {
    
    // MARK: - View

    private(set) weak var view: FavoritesListView?

	// MARK: - Constants

	private let nibName = "FavoritesListView"

	// MARK: - Private

    private func prepareView() -> FavoritesListView {
        let view = FavoritesListView(nibName: self.nibName, bundle: nil)
        self.view = view
        
        let interactor = FavoritesListInteractor()
        let presenter = FavoritesListPresenter()
        
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view
        view.presenter = presenter
        interactor.output = presenter
        
        return view
    }
}

// MARK: - Wireframe Protocol

extension FavoritesListWireframe: FavoritesListWireframeProtocol {
    func showFavoritesList(from tabBarController: UITabBarController) {
//        let view = self.prepareView()
    }

    func showFavoritesList(with navigationController: UINavigationController) {
        let view = self.prepareView()
        
        navigationController.show(view, sender: nil)
    }
}
