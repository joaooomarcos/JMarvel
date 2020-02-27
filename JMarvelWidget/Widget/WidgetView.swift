//
//  WidgetView.swift
//  JMarvelWidget
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import NotificationCenter
import UIKit

class WidgetView: UIViewController, NCWidgetProviding {
    
    // MARK: - Presenter
    
    var presenter: WidgetPresenterInputProtocol!
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var character1View: CharacterView!
    @IBOutlet weak var character2View: CharacterView!
    @IBOutlet weak var character3View: CharacterView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.presenter.loadData()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - Configuration
    
    func setup() {
        _ = WidgetWireframe(view: self)
    }
}

// MARK: - Character View Delegate

extension WidgetView: CharacterViewDelegate {
    func didTap(on character: CharacterRealm?) {
        self.presenter.didTap(on: character)
    }
}

// MARK: - Presenter Output

extension WidgetView: WidgetPresenterOutputProtocol {
    func didGet(character1: CharacterRealm?) {
        self.character1View.setup(with: character1, delegate: self)
    }
    
    func didGet(character2: CharacterRealm?) {
        self.character2View.setup(with: character2, delegate: self)
    }
    
    func didGet(character3: CharacterRealm?) {
        self.character3View.setup(with: character3, delegate: self)
    }
    
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
}
