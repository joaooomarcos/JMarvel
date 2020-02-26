//
//  MainRouterWireframeSpec.swift
//  JMarvelTests
//
//  Created by Joao Marcos Ribeiro Araujo on 2/26/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

@testable import JMarvel
import Nimble
import Quick
import UIKit

class MainRouterWireframeSpec: QuickSpec {
    override func spec() {
        describe("CharacterListWireframe") {
            
            var sut: MainRouterWireframe!
            var window: UIWindow!
            
            beforeEach {
                sut = MainRouterWireframe()
                window = UIWindow()
                
                sut.prepareInitial(window: window)
            }
            
            afterEach {
                sut = nil
                window = nil
            }
            
            it("should have a root view controller on window") {
                let viewController = window.rootViewController
                expect(viewController).toNot(beNil())
            }

            it("should have a tab bar controller on window") {
                let viewController = window.rootViewController
                expect(viewController).to(beAKindOf(UITabBarController.self))
            }
            
            it("should have two view controllers on tab bar controller") {
                let tabbar = window.rootViewController as? UITabBarController
                expect(tabbar?.viewControllers?.count).to(equal(2))
            }
            
            it("should have character list view controller as first on tab bar") {
                let tabbar = window.rootViewController as? UITabBarController
                let viewControllers = tabbar?.viewControllers
                let navigation = viewControllers?.first as? UINavigationController
                let firstVC = navigation?.viewControllers.first
                expect(firstVC).to(beAKindOf(CharacterListView.self))
            }
            
            it("should have favorite list view controller as last on tab bar") {
                let tabbar = window.rootViewController as? UITabBarController
                let viewControllers = tabbar?.viewControllers
                let navigation = viewControllers?.last as? UINavigationController
                let lastVC = navigation?.viewControllers.first
                expect(lastVC).to(beAKindOf(FavoritesListView.self))
            }
        }
    }
}
