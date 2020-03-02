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
                it("should tell the presenter to refreshData") {
                    sut.refreshData()
                    expect((sut.presenter as? CharacterListPresenterMock)?.refreshDataCalled).to(beTrue())
                }
                
                it("should tell the presenter that tap on item") {
                    let index = IndexPath(item: 0, section: 0)
                    sut.collectionView(sut.collectionView, didSelectItemAt: index)
                    expect((sut.presenter as? CharacterListPresenterMock)?.selectedItem).to(equal(index))
                }
                
                it("should tell the presenter that tap favorite on item") {
                    let model = CharacterModel.mock(0)
                    sut.didTapFavorite(model)
                    expect((sut.presenter as? CharacterListPresenterMock)?.favoritedItem).to(equal(model))
                }
            }

            context("Life Cycle") {
                it("should tell the presenter that the view is loaded") {
                    sut.viewDidLoad()
                    expect((sut.presenter as? CharacterListPresenterMock)?.viewDidLoadCalled).to(beTrue())
                }
                
                it("should tell the presenter that the view will appear") {
                    sut.viewWillAppear(true)
                    expect((sut.presenter as? CharacterListPresenterMock)?.viewWillAppearCalled).to(beTrue())
                }
            }
            
            context("Scroll") {
                it("should tell the presenter that the view needed more items") {
                    let items: [IndexPath] = []
                    sut.collectionView(sut.collectionView, prefetchItemsAt: items)
                    expect((sut.presenter as? CharacterListPresenterMock)?.loadMoreIndexPaths).to(equal(items))
                }
            }
            
            context("Presenter output") {
                it("should setup collection view when presenter demands") {
                    sut.setupCollectionView()
                    expect(sut.collectionView.refreshControl).toNot(beNil())
                    expect(sut.collectionView.prefetchDataSource).toNot(beNil())
                }
                
                it("should setup navigation bar when presenter demands") {
                    sut.setupNavigationBar()
                    expect(sut.navigationController?.navigationBar.prefersLargeTitles).to(beTrue())
                }
                
                it("should setup search when presenter demands") {
                    sut.setupSearch()
                    expect(sut.navigationItem.searchController).toNot(beNil())
                    expect(sut.navigationItem.searchController?.searchResultsUpdater).to(be(sut.presenter))
                }
                
                it("should show alert when presenter demands") {
                    let title = "title"
                    let message = "message"
                    sut.showAlert(title: title, message: message)
                    let alert = sut.presentedViewController as? UIAlertController
                    expect(alert?.title).to(equal(title))
                    expect(alert?.message).to(equal(message))
                }
                
                it("should show loading when presenter demands") {
                    sut.showLoading()
                    expect(sut.activityIndicator.isAnimating).to(beTrue())
                }
                
                it("should hide loading when presenter demands") {
                    sut.setupCollectionView()
                    sut.hideLoading()
                    expect(sut.activityIndicator.isAnimating).to(beFalse())
                    expect(sut.collectionView.refreshControl?.isRefreshing).to(beFalse())
                }
            }
        }
    }
}

class CharacterListPresenterMock: NSObject, CharacterListPresenterInputProtocol, UISearchResultsUpdating {
    var viewDidLoadCalled: Bool = false
    var viewWillAppearCalled: Bool = false
    var refreshDataCalled: Bool = false
    
    var size: CGSize?
    var loadMoreIndexPaths: [IndexPath]?
    var selectedItem: IndexPath?
    var favoritedItem: CharacterModel?
    
    func viewDidLoad() {
        self.viewDidLoadCalled = true
    }
    
    func viewWillAppear() {
        self.viewWillAppearCalled = true
    }
    
    func viewWillTransition(size: CGSize) {
        self.size = size
    }
    
    func refreshData() {
        self.refreshDataCalled = true
    }
    
    func loadMore(for indexPaths: [IndexPath]) {
        self.loadMoreIndexPaths = indexPaths
    }
    
    func didSelectItem(indexPath: IndexPath) {
        self.selectedItem = indexPath
    }
    
    func didTapFavorite(on model: CharacterModel) {
        self.favoritedItem = model
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

