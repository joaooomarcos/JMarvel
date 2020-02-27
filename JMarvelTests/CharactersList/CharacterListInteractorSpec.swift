//
//  CharacterListInteractorSpec.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 26/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

@testable import JMarvel
import Nimble
import Quick
import RealmSwift
import UIKit

class CharacterListInteractorSpec: QuickSpec {

    override func spec() {

        var sut: CharacterListInteractor!
        var api: CharacterAPIMock!
        var localDatabase: LocalDatabaseManagerMock!
        var presenter: CharacterListInteractorOutputMock!

        describe("CharacterListInteractor") {

            beforeEach {
                api = CharacterAPIMock()
                localDatabase = LocalDatabaseManagerMock()
                presenter = CharacterListInteractorOutputMock()
                
                sut = CharacterListInteractor(api: api, dataBase: localDatabase)
                sut.output = presenter
            }
            
            context("Input") {
                it("should call getList on API when call getCharacters") {
                    sut.getCharacters(with: 0)
                    expect(api.getListOffset).to(equal(0))
                }
                
                it("should call didGet when call getCharacters") {
                    api.success = true
                    sut.getCharacters(with: 0)
                    expect(presenter.didGetCalled).to(beTrue())
                }
                
                it("should call didFail when call getCharacters") {
                    api.success = false
                    sut.getCharacters(with: 0)
                    expect(presenter.didFailedCalled).to(beTrue())
                }
                
                it("should call didGetIdFavoritesList when call getFavorites") {
                    api.success = false
                    sut.getFavorites()
                    expect(presenter.didGetIdFavoritesListCalled).to(beTrue())
                }
                
                it("should call save on database when call updateLocal") {
                    sut.updateLocal(CharacterModel.mock(0))
                    expect(localDatabase.saveCalled).to(beTrue())
                }
                
                it("should call delete on database when call updateLocal") {
                    let model = CharacterModel.mock(0)
                    localDatabase.object = model
                    sut.updateLocal(model)
                    expect(localDatabase.deleteCalled).to(beTrue())
                }
                
            }
        }
    }
}

/*
 func updateLocal(_ model: CharacterModel) {
     let realmObject = CharacterRealm(model)
     if let dataBaseObject = dataBase.object(realmObject) {
         dataBase.delete(dataBaseObject)
     } else {
         dataBase.save(realmObject)
     }
 }
 */

class CharacterAPIMock: CharacterAPI {
    var success: Bool = true
    var getListCalled: Bool = false
    var getListOffset: Int?
    
    override func getList(with offset: Int, completion: @escaping (Result<Page<CharacterModel>>) -> Void) {
        self.getListOffset = offset
        self.getListCalled = true
        if success {
            let model = CharacterModel.mock(0)
            completion(Result.success(Page(results: [model])))
        } else {
            completion(Result.error(GenericError(message: "")))
        }
    }
}

class CharacterListInteractorOutputMock: CharacterListInteractorOutputProtocol {
    var didGetCalled: Bool = false
    var didFailedCalled: Bool = false
    var didGetIdFavoritesListCalled: Bool = false
    
    var failMessage: String?
    var ids: [Int]?
    
    func didGet(_ page: Page<CharacterModel>) {
        self.didGetCalled = true
    }
    
    func didFailed(_ error: GenericError) {
        self.didFailedCalled = true
        self.failMessage = error.message
    }
    
    func didGetIdFavoritesList(_ ids: [Int]) {
        self.didGetIdFavoritesListCalled = true
        self.ids = ids
    }
}

class LocalDatabaseManagerMock: LocalDatabaseManager {
    var deleteCalled: Bool = false
    var saveCalled: Bool = false
    var object: CharacterModel?
    
    override func delete<T>(_ object: T) where T : Object {
        self.deleteCalled = true
    }
    
    override func save<T>(_ object: T) where T : Object {
        self.saveCalled = true
    }
    
    override func object<T>(_ object: T) -> T? where T : CharacterRealm {
        if let obj = self.object {
            return obj.realmObject() as? T
        } else {
            return nil
        }
    }
}
