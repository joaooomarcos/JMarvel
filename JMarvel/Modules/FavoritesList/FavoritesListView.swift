//
//  FavoritesListView.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class FavoritesListView: UICollectionViewController {

    // MARK: - Presenter

    var presenter: FavoritesListPresenterInputProtocol!
    
    // MARK: - Constants
    
    // MARK: - Variables

    // MARK: - Outlets
    
    // MARK: - Actions

    // MARK: - Inits

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadData()
    }

    // MARK: - Privates

    // MARK: - Public

    // MARK: - Notifications
}

// MARK: - Presenter Output

extension FavoritesListView: FavoritesListPresenterOutputProtocol { }
