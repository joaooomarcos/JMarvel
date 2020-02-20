//
//  SceneDelegate.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
                
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let controller = storyBoard.instantiateViewController(withIdentifier: "CharacterListView") as? CharacterListView {
            let charactersWire = CharacterListWireframe(view: controller)
            let nav = UINavigationController(rootViewController: charactersWire.view ?? UIViewController())
            
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
    }
}
