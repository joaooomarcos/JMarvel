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
        viewControllers.append(favoritesList())
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = viewControllers
        
        return tabBar
    }
    
    private func charactersList() -> UIViewController {
        let wire = CharacterListWireframe()
        let navigation = wire.getNavigation() ?? UIViewController()
        navigation.tabBarItem = UITabBarItem(title: "Characters", image: #imageLiteral(resourceName: "iconCharacter"), selectedImage: #imageLiteral(resourceName: "iconCharacterFilled"))
        return navigation
    }
    
    private func favoritesList() -> UIViewController {
        let wire = FavoritesListWireframe()
        let navigation = wire.getNavigation() ?? UIViewController()
        navigation.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "iconStar"), selectedImage: #imageLiteral(resourceName: "iconStarFilled"))
        return navigation
    }
}

extension MainRouterWireframe: MainRouterWireframeProtocol {
    func prepareInitial(window: UIWindow?) {
        let tabBar = self.createTabBar()
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}
