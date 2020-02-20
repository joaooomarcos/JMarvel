//
//  CharacterListPresenter.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presenter Input Protocol

protocol CharacterListPresenterInputProtocol: class {
    func loadData()
}

// MARK: - Presenter Output Protocol

protocol CharacterListPresenterOutputProtocol: class {
    func didGet(_ characters: [CharacterListItem])
    func didFail(_ message: String)
}

class CharacterListPresenter: NSObject {
    
    // MARK: - Variables
    
    private var models: [CharacterListItem] = []
    
    // MARK: - Viper 
    
    weak var view: CharacterListPresenterOutputProtocol!
    var interactor: CharacterListInteractorInputProtocol!
    var wireframe: CharacterListWireframeProtocol!
}

// MARK: - HomePresenterInputProtocol

extension CharacterListPresenter: CharacterListPresenterInputProtocol {
    func loadData() {
        self.interactor.getCharacters()
    }
}

// MARK: - HomePresenterInteractorOutputProtocol

extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    func didGet(_ page: Page<CharacterModel>) {
        guard let results = page.results else {
            self.view.didFail("")
            return
        }
        
        self.models = results.compactMap({ CharacterListItem($0) })
        self.view.didGet(models)
    }
    
    func didFailed(_ error: GenericError) {
        self.view.didFail(error.message)
    }
}

extension CharacterListPresenter: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if searchText.isEmpty {
            self.view.didGet(self.models)
            return
        }
        
        let filtered = models.filter { item -> Bool in
            item.name.lowercased().contains(searchText.lowercased())
        }
        
        self.view.didGet(filtered)
    }
}
