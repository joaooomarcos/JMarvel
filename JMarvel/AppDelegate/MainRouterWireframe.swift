//
//  MainRouterWireframe.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

protocol MainRouterWireframeProtocol: class {
    func prepareInitial(window: UIWindow?)
}

class MainRouterWireframe {
    
    // MARK: - Privates
    
    private func createTabBar() -> UITabBarController {
        var viewControllers: [UIViewController] = []
        
        viewControllers.append(charactersList())
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = viewControllers
        
        return tabBar
    }
    
    private func charactersList() -> UIViewController {
        let wire = CharacterListWireframe()
        return wire.getNavigation() ?? UIViewController()
    }
    
    private func favoritesList() -> UIViewController {
        let wire = CharacterListWireframe()
        return wire.getNavigation() ?? UIViewController()
    }
}

extension MainRouterWireframe: MainRouterWireframeProtocol {
    func prepareInitial(window: UIWindow?) {
        let tabBar = self.createTabBar()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}
