//
//  WidgetPresenter.swift
//  JMarvelWidget
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

// MARK: - Presenter Input Declaration

protocol WidgetPresenterInputProtocol: class {
    func loadData()
    func didTap(on item: CharacterRealm?)
}

// MARK: - Presenter Output Declaration

protocol WidgetPresenterOutputProtocol: class {
    func didGet(character1: CharacterRealm?)
    func didGet(character2: CharacterRealm?)
    func didGet(character3: CharacterRealm?)
    func showLoading()
    func hideLoading()
}

// MARK: - Presenter

class WidgetPresenter {

    // MARK: - Viper

    weak var view: WidgetPresenterOutputProtocol?
    var interactor: WidgetInteractorInputProtocol!
    var wireframe: WidgetWireframeProtocol!
}

// MARK: - Presenter Input

extension WidgetPresenter: WidgetPresenterInputProtocol {
    func loadData() {
        self.view?.showLoading()
        self.interactor.getFavorites(limit: 3)
    }
    
    func didTap(on item: CharacterRealm?) {
        self.wireframe.openDetail(model: item)
    }
}

// MARK: - Interactor Output

extension WidgetPresenter: WidgetInteractorOutputProtocol {
    func didGetFavorites(_ list: [CharacterRealm]) {
        self.view?.hideLoading()
        
        if list.count >= 1 {
            self.view?.didGet(character1: list[0])
        } else {
            self.view?.didGet(character1: nil)
        }
        
        if list.count >= 2 {
            self.view?.didGet(character2: list[1])
        } else {
            self.view?.didGet(character2: nil)
        }
        
        if list.count >= 3 {
            self.view?.didGet(character3: list[2])
        } else {
            self.view?.didGet(character3: nil)
        }
    }
}
