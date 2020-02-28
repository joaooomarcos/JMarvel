//
//  CharacterListPresenterSpec.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 26/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

@testable import JMarvel
import Nimble
import Quick
import UIKit

class CharacterListPresenterSpec: QuickSpec {

    override func spec() {

        describe("CharacterListPresenter") {

            var sut: CharacterListPresenter!
            var view: CharacterListViewMock!
            var interactor: CharacterListInteractorMock!
            var wireframe: CharacterListWireframeMock!
            var models: [CharacterModel]!
            
            beforeEach {
                models = [CharacterModel.mock(0), CharacterModel.mock(1)]
                sut = CharacterListPresenter(models, totalItems: 5)
                view = CharacterListViewMock()
                interactor = CharacterListInteractorMock()
                wireframe = CharacterListWireframeMock()
                
                sut.wireframe = wireframe
                sut.interactor = interactor
                sut.view = view
            }

            afterEach {
                sut.wireframe = nil
                sut.interactor = nil
                sut.view = nil
                sut = nil
            }

            context("Input protocol") {
                it("should call interactor to getCharacters when call loadData") {
                    sut.viewDidLoad()
                    expect(interactor.getCharactersCalled).to(beTrue())
                }
                
                it("should call show loading when call loadData") {
                    sut.viewDidLoad()
                    expect(view.showLoadingCalled).to(beTrue())
                }
                
                it("should call interactor to getCharacters when call refreshData") {
                    sut.refreshData()
                    expect(interactor.getCharactersCalled).to(beTrue())
                }
                
                it("should call interactor to getCharacters when call loadMore") {
                    sut.loadMore(for: [IndexPath(row: 1, section: 0)])
                    expect(interactor.getCharactersCalled).to(beTrue())
                }
                
                it("should not call interactor to getCharacters when called loadMore with indexpath lower than models.count") {
                    sut.loadMore(for: [IndexPath(row: 0, section: 0)])
                    expect(interactor.getCharactersCalled).to(beFalse())
                }
                
                it("should not call interactor when indexpath on load more is empty") {
                    sut.loadMore(for: [])
                    expect(interactor.getCharactersCalled).to(beFalse())
                }
                
                it("should not call interactor to getCharacters when reach total items") {
                    let models = [CharacterModel.mock(0), CharacterModel.mock(1)]
                    sut = CharacterListPresenter(models, totalItems: 2)
                    
                    sut.wireframe = wireframe
                    sut.interactor = interactor
                    sut.view = view
                    
                    sut.loadMore(for: [IndexPath(row: 1, section: 0)])
                    expect(interactor.getCharactersCalled).to(beFalse())
                }
                
                it("should not call interactor to getCharacters when called loadMore with indexpath lower than models.count") {
                    sut.loadMore(for: [IndexPath(row: 0, section: 0)])
                    expect(interactor.getCharactersCalled).to(beFalse())
                }
                
                it("should call once interactor to getCharacters when isFetching for another call") {
                    sut.viewDidLoad()
                    sut.loadMore(for: [IndexPath(row: 0, section: 0)])
                    expect(interactor.getCharacterCalledCount).to(equal(1))
                }
                
                it("should call wireframe to navigate when call didSelectItem") {
                    sut.didSelectItem(indexPath: IndexPath(row: 0, section: 0))
                    expect(wireframe.navigateToDetailCalled).to(beTrue())
                }
                
                it("should call interactor to favorite when call didTapFavorite") {
                    sut.didTapFavorite(on: CharacterModel.mock(0))
                    expect(interactor.updateLocalCalled).to(beTrue())
                }
            }

            context("Output protocol") {
                it("should be favorite models id returned by interactor") {
                    let id = 0
                    sut.didGetIdFavoritesList([id])
                    let models = models.filter({ $0.id == id && $0.isFavorited })
                    expect(models.count).to(equal(1))
                }
                
                it("should call hide loading when interactor call didGet") {
                    sut.didGet(Page())
                    expect(view.hideLoadingCalled).to(beTrue())
                }
                
                it("should call didFailed when didGet does not has results") {
                    sut.didGet(Page())
                    expect(view.emptyMessage).toNot(beEmpty())
                }
                
                it("should call hide loading when called didFailed") {
                    sut.didFailed(GenericError(message: ""))
                    expect(view.hideLoadingCalled).to(beTrue())
                }
                
                it("should call didFail when called didFailed") {
                    let failMessage = "fail"
                    sut.didFailed(GenericError(message: failMessage))
                    expect(view.alertMessage).to(contain(failMessage))
                }
            }
            
            context("Search Control protocol") {
                it("should return all models when search text is empty") {
                    let search = SearchControlMock()
                    search.text = ""
                    sut.updateSearchResults(for: search)
                    expect(view.characters?.count).to(equal(models.count))
                }
                
                it("should return filtered models based on search text") {
                    let searchText = "me1"
                    let search = SearchControlMock()
                    search.text = "name1"
                    
                    let filtered = models.filter { item -> Bool in
                        (item.name ?? "").lowercased().contains(searchText.lowercased())
                    }
                    
                    sut.updateSearchResults(for: search)
                    expect(view.characters?.count).to(equal(filtered.count))
                }
            }
        }
    }
}

class SearchControlMock: UISearchController {
    var text: String?
    
    override var searchBar: UISearchBar {
        let bar = UISearchBar()
        bar.text = text
        return bar
    }
}

class CharacterListViewMock: CharacterListPresenterOutputProtocol {
    var setupCollectionViewCalled: Bool = false
    var setupNavigationBarCalled: Bool = false
    var setupSearchCalled: Bool = false
    var setupLayoutCalled: Bool = false
    var reloadCollectionLayoutCalled: Bool = false
    var showLoadingCalled: Bool = false
    var hideLoadingCalled: Bool = false
    
    var itemSize: CGSize?
    var spacing: CGFloat?
    var characters: [CharacterModel]?
    var alertTitle: String?
    var alertMessage: String?
    var emptyMessage: String?
    
    func setupCollectionView() {
        self.setupCollectionViewCalled = true
    }
    
    func setupNavigationBar() {
        self.setupNavigationBarCalled = true
    }
    
    func setupSearch() {
        self.setupSearchCalled = true
    }
    
    func setupLayout() {
        self.setupLayoutCalled = true
    }
    
    func didCalculate(itemSize: CGSize, spacing: CGFloat) {
        self.itemSize = itemSize
        self.spacing = spacing
    }
    
    func reloadCollectionLayout() {
        self.reloadCollectionLayoutCalled = true
    }
    
    func didGet(_ characters: [CharacterModel]) {
        self.characters = characters
    }
    
    func showAlert(title: String, message: String) {
        self.alertTitle = title
        self.alertMessage = message
    }
    
    func showEmptyState(message: String) {
        self.emptyMessage = message
    }
    
    func showLoading() {
        self.showLoadingCalled = true
    }
    
    func hideLoading() {
        self.hideLoadingCalled = true
    }
}

class CharacterListInteractorMock: CharacterListInteractorInputProtocol {
    var getCharactersCalled: Bool = false
    var updateLocalCalled: Bool = false
    var getFavoritesCalled: Bool = false
    var getCharacterCalledCount: Int = 0
    
    func getCharacters(with offset: Int) {
        self.getCharacterCalledCount += 1
        self.getCharactersCalled = true
    }
    
    func updateLocal(_ model: CharacterModel) {
        self.updateLocalCalled = true
    }
    
    func getFavorites() {
        self.getFavoritesCalled = true
    }
}

class CharacterListWireframeMock: CharacterListWireframeProtocol {
    var getNavigationCalled: Bool = false
    var navigateToDetailCalled: Bool = false
    
    func getNavigation() -> UINavigationController? {
        self.getNavigationCalled = true
        return UINavigationController()
    }
    
    func navigateToDetail(model: CharacterModel) {
        self.navigateToDetailCalled = true
    }
}
