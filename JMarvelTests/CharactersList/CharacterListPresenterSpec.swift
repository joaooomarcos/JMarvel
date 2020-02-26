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
            
            beforeEach {
                let models = [CharacterModel.mock(), CharacterModel.mock()]
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
                    sut.loadData()
                    expect(interactor.getCharactersCalled).to(beTrue())
                }
                
                it("should call show loading when call loadData") {
                    sut.loadData()
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
                
                it("should not call interactor to getCharacters when reach total items") {
                    let models = [CharacterModel.mock(), CharacterModel.mock()]
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
                    sut.loadData()
                    sut.loadMore(for: [IndexPath(row: 0, section: 0)])
                    expect(interactor.getCharacterCalledCount).to(equal(1))
                }
                
                it("should call wireframe to navigate when call didSelectItem") {
                    sut.didSelectItem(indexPath: IndexPath(row: 0, section: 0))
                    expect(wireframe.navigateToDetailCalled).to(beTrue())
                }
                
                it("should call interactor to favorite when call didTapFavorite") {
                    sut.didTapFavorite(on: CharacterModel.mock())
                    expect(interactor.updateLocalCalled).to(beTrue())
                }
            }

            context("Output protocol") {
                
            }
        }
    }
}

class CharacterListViewMock: CharacterListPresenterOutputProtocol {
    var didGetCalled: Bool = false
    var didFailCalled: Bool = false
    var showLoadingCalled: Bool = false
    var hideLoadingCalled: Bool = false
    
    func didGet(_ characters: [CharacterModel]) {
        self.didGetCalled = true
    }
    
    func didFail(_ message: String) {
        self.didFailCalled = true
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
