//
//  FavoritesListInteractor.swift
//  JMarvel
//
//  Created Joao Marcos Ribeiro Araujo on 21/02/2020.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//
import Foundation

// MARK: - Interactor Input Declaration

protocol FavoritesListInteractorInputProtocol: class { }

// MARK: - Interactor Output Declaration

protocol FavoritesListInteractorOutputProtocol: class {
}

// MARK: - Interactor

class FavoritesListInteractor {

    // MARK: - Output

    weak var output: FavoritesListInteractorOutputProtocol?

    // MARK: - Variables

    // MARK: - Inits

    // MARK: - Privates
}

// MARK: - Interactor Input

extension FavoritesListInteractor: FavoritesListInteractorInputProtocol { }
