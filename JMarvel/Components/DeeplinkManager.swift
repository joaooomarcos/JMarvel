//
//  DeeplinkManager.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

enum DeepLinkType {
    case home
    case favorites
    case detail(id: Int)
}

class DeepLinkManager {
    
    // MARK: - Variables
    
    static let shared = DeepLinkManager()
    private var deepLinkType: DeepLinkType?
    
    // MARK: - Methods
    
    //UIScene.ConnectionOptions
    
    func handleDeeplink(_ connection: UIScene.ConnectionOptions) {
        self.handleDeeplink(connection.urlContexts)
        
        if let shortcut = connection.shortcutItem {
            self.handleDeeplink(shortcut)
        }
    }
    
    @discardableResult
    func handleDeeplink(_ URLContexts: Set<UIOpenURLContext>) -> Bool {
        guard let url = URLContexts.first?.url else { return false }
        deepLinkType = self.parse(url)
        return deepLinkType != nil
    }
    
    @discardableResult
    func handleDeeplink(_ url: URL) -> Bool {
        deepLinkType = self.parse(url)
        return deepLinkType != nil
    }
    
    @discardableResult
    func handleDeeplink(_ shortcut: UIApplicationShortcutItem) -> Bool {
        deepLinkType = self.parse(shortcut)
        return deepLinkType != nil
    }
    
    func checkDeepLink() {
        guard let deepLinkType = deepLinkType else {
            return
        }

        DeeplinkRouter().proceedToDeeplink(deepLinkType)
        
        self.deepLinkType = nil
    }
    
    func parse(_ url: URL) -> DeepLinkType? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return nil
        }
        
        switch host {
        case "home":
            return DeepLinkType.home
        case "favorites":
            return DeepLinkType.favorites
        case "detail":
            let id = Int(components.path.dropFirst()) ?? -1
            return DeepLinkType.detail(id: id)
        default:
            break
        }
        
        return nil
    }
    
    func parse(_ shortcut: UIApplicationShortcutItem) -> DeepLinkType? {
        let item = shortcut.type.components(separatedBy: ".").last ?? ""
        
        switch item {
        case "home":
            return DeepLinkType.home
        case "favorites":
            return DeepLinkType.favorites
        default:
            break
        }
        
        return nil
    }
}
