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
    func refreshData()
    func loadMore(for indexPaths: [IndexPath])
    func didSelectItem(indexPath: IndexPath)
}

// MARK: - Presenter Output Protocol

protocol CharacterListPresenterOutputProtocol: class {
    func didGet(_ characters: [CharacterModel])
    func didFail(_ message: String)
    func showLoading()
    func hideLoading()
}

class CharacterListPresenter: NSObject {
    
    // MARK: - Variables
    
    private var models: [CharacterModel] = []
    private var isFetchingItems: Bool = false
    private var totalItemsAvailable: Int = .max
    
    // MARK: - Viper 
    
    weak var view: CharacterListPresenterOutputProtocol!
    var interactor: CharacterListInteractorInputProtocol!
    var wireframe: CharacterListWireframeProtocol!
}

// MARK: - Input Protocol

extension CharacterListPresenter: CharacterListPresenterInputProtocol {
    func loadData() {
        self.isFetchingItems = true
        self.models = []
        self.interactor.getCharacters(with: self.models.count)
        self.view.showLoading()
    }
    
    func refreshData() {
        self.isFetchingItems = true
        self.models = []
        self.interactor.getCharacters(with: self.models.count)
    }
    
    func loadMore(for indexPaths: [IndexPath]) {
        guard !isFetchingItems else { return }
        guard totalItemsAvailable > self.models.count else { return }
        
        for index in indexPaths where index.row >= (self.models.count - 1) {
            self.interactor.getCharacters(with: self.models.count)
            return
        }
    }
    
    func didSelectItem(indexPath: IndexPath) {
        self.wireframe.navigateToDetail(model: self.models[indexPath.row])
    }
}

// MARK: - Output Protocol
 
extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    func didGet(_ page: Page<CharacterModel>) {
        self.view.hideLoading()
        self.isFetchingItems = false
        self.totalItemsAvailable = page.total ?? 0
        
        guard let results = page.results else {
            self.view.didFail("")
            return
        }
        
        print(results)
        
        self.models += results
        self.view.didGet(models)
    }
    
    func didFailed(_ error: GenericError) {
        self.isFetchingItems = false
        self.view.hideLoading()
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
            (item.name ?? "").lowercased().contains(searchText.lowercased())
        }
        
        self.view.didGet(filtered)
    }
}
