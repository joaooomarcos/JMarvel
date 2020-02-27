//
//  WidgetWireframe.swift
//  JMarvelWidget
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

// MARK: - Wireframe Protocol Declaration

protocol WidgetWireframeProtocol: class {
    func openDetail(model: CharacterRealm?)
}

// MARK: - Wireframe

class WidgetWireframe {
    
    // MARK: - View
    
    private(set) weak var view: WidgetView?
    
    // MARK: - Init
    
    init(view: WidgetView) {
        self.view = view
        self.prepare()
    }
    
    // MARK: - Private
    
    private func prepare() {
        let interactor = WidgetInteractor()
        let presenter = WidgetPresenter()
        
        presenter.interactor = interactor
        presenter.wireframe = self
        presenter.view = view
        
        view?.presenter = presenter
        interactor.output = presenter
    }
}

extension WidgetWireframe: WidgetWireframeProtocol {
    func openDetail(model: CharacterRealm?) {
        let url: URL?
        
        if let model = model {
            url = URL(string: "jmarvel://detail/\(model.id)")
        } else {
            url = URL(string: "jmarvel://favorites")
        }
        
        guard let unwrappedURL = url else { return }
        self.view?.extensionContext?.open(unwrappedURL)
    }
}
