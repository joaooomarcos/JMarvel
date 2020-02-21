//
//  CharacterDetailsPresenter.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Presenter Input Declaration

protocol CharacterDetailsPresenterInputProtocol: class {
    func loadData()
    func didTapFavorite()
}

// MARK: - Presenter Output Declaration

protocol CharacterDetailsPresenterOutputProtocol: class {
    func prepareLayout(seriesIsHidden: Bool, comicsIsHidden: Bool)
    func didGet(imageURL: URL?, description: String)
    func didGet(series items: [PosterItem])
    func didGet(comics items: [PosterItem])
    func updateLayout(isFavorited: Bool)
}

// MARK: - Presenter

class CharacterDetailsPresenter {
    
    // MARK: - Viper
    
    weak var view: CharacterDetailsPresenterOutputProtocol!
    var interactor: CharacterDetailsInteractorInputProtocol!
    var wireframe: CharacterDetailsWireframeProtocol!
    
    // MARK: - Variables
    
    private var model: CharacterModel
    private var comics: [PosterItem] = []
    private var series: [PosterItem] = []
    
    // MARK: - Init
    
    init(_ model: CharacterModel) {
        self.model = model
    }
    
    // MARK: - Privates
    
    private var hasSeries: Bool {
        (self.model.series?.available ?? 0) > 0
    }
    
    private var hasComics: Bool {
        (self.model.comics?.available ?? 0) > 0
    }
    
    private func loadSeries() {
        guard self.hasSeries else { return }
        self.interactor.getSeries(with: self.model.id)
    }
    
    private func loadComics() {
        guard self.hasComics else { return }
        self.interactor.getComics(with: self.model.id)
    }
}

// MARK: - Presenter Input

extension CharacterDetailsPresenter: CharacterDetailsPresenterInputProtocol {
    func loadData() {
        self.loadSeries()
        self.loadComics()
        self.view.prepareLayout(seriesIsHidden: !self.hasSeries, comicsIsHidden: !self.hasComics)
        self.view.didGet(imageURL: self.model.image?.image(kind: .landscape), description: self.model.summary ?? "")
        self.view.updateLayout(isFavorited: self.model.isFavorited)
    }
    
    func didTapFavorite() {
        self.interactor.updateLocal(model)
        model.isFavorited.toggle()
        self.view.updateLayout(isFavorited: model.isFavorited)
    }
}

// MARK: - Interactor Output

extension CharacterDetailsPresenter: CharacterDetailsInteractorOutputProtocol {
    func didGet(series page: Page<PosterItem>) {
        guard let results = page.results else {
            return
        }
        
        self.series = results
        self.view.didGet(series: series)
    }
    
    func didGet(comics page: Page<PosterItem>) {
        guard let results = page.results else {
            return
        }
        
        self.comics = results
        self.view.didGet(comics: comics)
    }
    
    func didFailed(_ error: GenericError) { }
}
