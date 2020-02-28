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
    func viewDidLoad()
    func viewWillAppear()
    func viewWillTransition(size: CGSize)
    func refreshData()
    func loadMore(for indexPaths: [IndexPath])
    func didSelectItem(indexPath: IndexPath)
    func didTapFavorite(on model: CharacterModel)
}

// MARK: - Presenter Output Declaration

protocol CharacterListPresenterOutputProtocol: class {
    func setupCollectionView()
    func setupNavigationBar()
    func setupSearch()
    func setupLayout()
    func didCalculate(itemSize: CGSize, spacing: CGFloat)
    func reloadCollectionLayout()
    func didGet(_ characters: [CharacterModel])
    func showAlert(title: String, message: String)
    func showEmptyState(message: String)
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
    
    private var itemSize: CGSize = .zero
    private var isFetchingItems: Bool = false
    private var totalItemsAvailable: Int
    
    init(_ models: [CharacterModel] = [], totalItems: Int = .max) {
        self.models = models
        self.totalItemsAvailable = totalItems
    }
    
    private func loadData() {
        self.isFetchingItems = true
        self.interactor.getCharacters(with: 0)
        self.view.showLoading()
        self.view.showEmptyState(message: "Searching... 🔍")
    }
}

// MARK: - Presenter Input

extension CharacterListPresenter: CharacterListPresenterInputProtocol {
    func viewDidLoad() {
        self.view.setupCollectionView()
        self.view.setupNavigationBar()
        self.view.setupSearch()
        self.view.setupLayout()
        self.loadData()
    }
    
    func viewWillAppear() {
        self.refreshData()
    }
    
    func viewWillTransition(size: CGSize) {
        let helper = SizeHelper()
        self.itemSize = helper.itemSize(for: size.width)
        self.view.didCalculate(itemSize: self.itemSize, spacing: Constants.Dimensions.spacing)
    }
    
    func refreshData() {
        guard !isFetchingItems else { return }
        
        if self.models.isEmpty {
            self.view.showLoading()
            self.view.showEmptyState(message: "Searching... 🔍")
        }
        
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
            self.view.didGet([])
            self.view.showEmptyState(message: "Nothing to show 😲")
            return
        }
        
        self.models += results
        self.view.didGet(models)
    }
    
    func didFailed(_ error: GenericError) {
        self.isFetchingItems = false
        self.models = []
        self.view.hideLoading()
        self.view.didGet([])
        self.view.showEmptyState(message: "Nothing to show 😲")
        self.view.showAlert(title: "Error", message: error.message + "🥺")
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
        
        if filtered.isEmpty {
            self.view.showEmptyState(message: "Nothing to show 😲")
        }
    }
}
