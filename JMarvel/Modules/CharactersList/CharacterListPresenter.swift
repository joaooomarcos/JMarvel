//
//  CharacterListPresenter.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/19/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Presenter Input Declaration

protocol CharacterListPresenterInputProtocol: class {
    func loadData()
    func refreshData()
    func loadMore(for indexPaths: [IndexPath])
    func didSelectItem(indexPath: IndexPath)
    func didTapFavorite(on model: CharacterModel)
}

// MARK: - Presenter Output Declaration

protocol CharacterListPresenterOutputProtocol: class {
    func didGet(_ characters: [CharacterModel])
    func didFail(_ message: String)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter

class CharacterListPresenter: NSObject {
    
    // MARK: - Viper
    
    weak var view: CharacterListPresenterOutputProtocol!
    var interactor: CharacterListInteractorInputProtocol!
    var wireframe: CharacterListWireframeProtocol!
    
    // MARK: - Variables
    
    private var models: [CharacterModel] {
        didSet {
            self.interactor.getFavorites()
        }
    }
    
    private var isFetchingItems: Bool = false
    private var totalItemsAvailable: Int
    
    init(_ models: [CharacterModel] = [], totalItems: Int = .max) {
        self.models = models
        self.totalItemsAvailable = totalItems
    }
}

// MARK: - Presenter Input

extension CharacterListPresenter: CharacterListPresenterInputProtocol {
    func loadData() {
        self.isFetchingItems = true
        self.interactor.getCharacters(with: 0)
        self.view.showLoading()
    }
    
    func refreshData() {
        guard !isFetchingItems else { return }
        
        self.isFetchingItems = true
        self.interactor.getCharacters(with: 0)
    }
    
    func loadMore(for indexPaths: [IndexPath]) {
        guard !isFetchingItems else { return }
        guard totalItemsAvailable > self.models.count else { return }
        
        for index in indexPaths where index.row >= (self.models.count - 1) {
            self.interactor.getCharacters(with: self.models.count)
            self.isFetchingItems = true
            return
        }
    }
    
    func didSelectItem(indexPath: IndexPath) {
        self.wireframe.navigateToDetail(model: self.models[indexPath.row])
    }
    
    func didTapFavorite(on model: CharacterModel) {
        self.interactor.updateLocal(model)
    }
}

// MARK: - Interactor Output
 
extension CharacterListPresenter: CharacterListInteractorOutputProtocol {
    func didGetIdFavoritesList(_ ids: [Int]) {
        for id in ids {
            let model = self.models.first { $0.id == id }
            model?.isFavorited = true
        }
    }
    
    func didGet(_ page: Page<CharacterModel>) {
        self.view.hideLoading()
        self.isFetchingItems = false
        
        if page.offset == 0 {
            self.models = []
        }
        
        self.totalItemsAvailable = page.total ?? 0
        
        guard let results = page.results else {
            self.view.didFail("")
            return
        }
        
        self.models += results
        self.view.didGet(models)
    }
    
    func didFailed(_ error: GenericError) {
        self.isFetchingItems = false
        self.view.hideLoading()
        self.view.didFail(error.message)
    }
}

// MARK: - UISearchResultsUpdating

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
