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
    
    private let charactersList: CharacterListWireframe
    private let favoritesList: FavoritesListWireframe
    
    init(characters: CharacterListWireframe = CharacterListWireframe(),
         favorites: FavoritesListWireframe = FavoritesListWireframe()) {
        self.charactersList = characters
        self.favoritesList = favorites
    }
    
    private func createTabBar() -> UITabBarController {
        var viewControllers: [UIViewController] = []
        
        if let characters = getNavigationOfcharactersList() {
            viewControllers.append(characters)
        }
        
        if let favorites = getNavigationOffavoritesList() {
            viewControllers.append(favorites)
        }
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = viewControllers
        
        return tabBar
    }
    
    private func getNavigationOfcharactersList() -> UINavigationController? {
        let navigation = charactersList.getNavigation()
        navigation?.tabBarItem = UITabBarItem(title: "Characters", image: #imageLiteral(resourceName: "iconCharacter"), selectedImage: #imageLiteral(resourceName: "iconCharacterFilled"))
        return navigation
    }
    
    private func getNavigationOffavoritesList() -> UINavigationController? {
        let navigation = favoritesList.getNavigation()
        navigation?.tabBarItem = UITabBarItem(title: "Favorites", image: #imageLiteral(resourceName: "iconStar"), selectedImage: #imageLiteral(resourceName: "iconStarFilled"))
        return navigation
    }
}

extension MainRouterWireframe: MainRouterWireframeProtocol {
    func prepareInitial(window: UIWindow?) {
        let tabBar = self.createTabBar()
        window?.rootViewController = tabBar
        window?.tintColor = UIColor(named: "main")
        window?.makeKeyAndVisible()
    }
}
