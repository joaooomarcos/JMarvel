//
//  CharacterListViewSpec.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 26/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

@testable import JMarvel
import Nimble
import Quick
import UIKit

class CharacterListViewSpec: QuickSpec {

    override func spec() {

        describe("CharacterListView") {

            var sut: CharacterListView!

            var navigationController: UINavigationController!

            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                sut = storyboard.instantiateViewController(identifier: "CharacterListView")
                navigationController = UINavigationController(rootViewController: sut)
                
                let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
                keyWindow?.rootViewController = navigationController

                sut.presenter = CharacterListPresenterMock()

                _ = navigationController.view
                _ = sut.view

                sut.viewDidLoad()
            }

            afterEach {
                sut = nil
                navigationController =  nil
            }

            context("Initialization") {
                it("should be a valid reference") {
                    expect(sut).toNot(beNil())
                }

                it("should have all outlets connceted") {
                    expect(sut.activityIndicator).toNot(beNil())
                }
            }

            context("Actions") {
                it("should tell the presenter that tap on item") {
                    sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
                    expect((sut.presenter as? CharacterListPresenterMock)?.didSelectItemCalled).to(beTrue())
                }
                
                it("should tell the presenter that tap favorite on item") {
                    let json = """
                    {
                     "id": 0
                    }
                    """.data(using: .utf8)!
                    
                    let model = try! JSONDecoder().decode(CharacterModel.self, from: json)
                    sut.didTapFavorite(model)
                    expect((sut.presenter as? CharacterListPresenterMock)?.didTapFavoriteCalled).to(beTrue())
                }
            }

            context("Load data") {
                it("should tell the presenter that the view is loaded") {
                    sut.viewDidLoad()
                    expect((sut.presenter as? CharacterListPresenterMock)?.loadDataCalled).to(beTrue())
                }
                
                it("should tell the presenter that the view needed to be refreshed") {
                    sut.viewWillAppear(true)
                    expect((sut.presenter as? CharacterListPresenterMock)?.refreshDataCalled).to(beTrue())
                }
                
                it("should tell the presenter that the view needed more items") {
                    sut.collectionView(sut.collectionView, prefetchItemsAt: [])
                    expect((sut.presenter as? CharacterListPresenterMock)?.loadMoreCalled).to(beTrue())
                }
            }
        }
    }
}

class CharacterListPresenterMock: CharacterListPresenterInputProtocol {
	var loadDataCalled: Bool = false
    var refreshDataCalled: Bool = false
    var loadMoreCalled: Bool = false
    var didSelectItemCalled: Bool = false
    var didTapFavoriteCalled: Bool = false
    
    func loadData() {
        self.loadDataCalled = true
    }
    
    func refreshData() {
        self.refreshDataCalled = true
    }
    
    func loadMore(for indexPaths: [IndexPath]) {
        self.loadMoreCalled = true
    }
    
    func didSelectItem(indexPath: IndexPath) {
        self.didSelectItemCalled = true
    }
    
    func didTapFavorite(on model: CharacterModel) {
        self.didTapFavoriteCalled = true
    }
}
