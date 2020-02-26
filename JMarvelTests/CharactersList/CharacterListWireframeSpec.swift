//
//  CharacterListWireframeSpec.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 26/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

@testable import JMarvel
import Nimble
import Quick
import UIKit

class CharacterListWireframeSpec: QuickSpec {

	override func spec() {

		describe("CharacterListWireframe") {

            var sut: CharacterListWireframe!
            
            beforeEach {
                sut = CharacterListWireframe()
                _ = sut.getNavigation()
            }
            
			it("should have a valid view") {
				 expect(sut.view).toNot(beNil())
			}

			it("should connect view to a valid presenter") {
                expect(sut.view?.presenter).toNot(beNil())
            }
            
            it("should connect presenter to a valid interactor") {
                let presenter = sut.view?.presenter as? CharacterListPresenter
                expect(presenter?.interactor).toNot(beNil())
            }

            it("should connect presenter's view to the same instance of wireframe's view") {
                let presenter = sut.view?.presenter as? CharacterListPresenter
                expect(presenter?.view).to(be(sut.view))
            }

            it("should connect presenter's wireframe to the same instance of this module's wireframe") {
				let presenter = sut.view?.presenter as? CharacterListPresenter
				let wireframe = presenter?.wireframe as? CharacterListWireframe

				expect(wireframe).to(be(sut))
			}

			it("should connect interactor's output to the same instance of presenter's interactor") {
				let presenter = sut.view?.presenter as? CharacterListPresenter
				let interactor = presenter?.interactor as? CharacterListInteractor

				expect(interactor?.output).to(be(presenter))
			}
            
            it("should navigate to character detail on call") {
                let window = UIWindow()
                let router = MainRouterWireframe(characters: sut)
                router.prepareInitial(window: window)
                
                let json = """
                {
                 "id": 0
                }
                """.data(using: .utf8)!
                
                let model = try! JSONDecoder().decode(CharacterModel.self, from: json)
                
                sut.navigateToDetail(model: model)
                expect(sut.view?.navigationController?.viewControllers.last).toEventually(beAKindOf(CharacterDetailsViewController.self))
            }
		}
	}
}
