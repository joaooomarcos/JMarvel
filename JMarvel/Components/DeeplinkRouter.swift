//
//  DeeplinkNavigator.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class DeeplinkRouter {

    func proceedToDeeplink(_ type: DeepLinkType) {
        switch type {
        case .home:
            self.navigateToHome()
        case .favorites:
            self.navigateToFavorites()
        case .detail(let id):
            self.navigateToDetail(id: id)
        }
    }
    
    func navigateToHome() {
        let tabbar = self.getTabBarController()
        tabbar?.selectedIndex = 0
    }
    
    func navigateToFavorites() {
        let tabbar = self.getTabBarController()
        tabbar?.selectedIndex = 1
    }
    
    func navigateToDetail(id: Int) {
        guard let viewController = self.getTopViewController() else { return }
        let wireframe = CharacterDetailsWireframe()
        wireframe.present(with: id, from: viewController)
    }
    
    func getTabBarController() -> UITabBarController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        return keyWindow?.rootViewController as? UITabBarController
    }
    
    func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        return keyWindow?.rootViewController
    }
}
