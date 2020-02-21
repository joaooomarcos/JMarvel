//
//  CharactersDetailsAPI.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 2/20/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharactersDetailsAPI {
    
    // MARK: - Variables
    
    private var httpClient: HTTPClient
    
    // MARK: - Init
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    // MARK: - Public
    
    func getSeries(with id: Int, completion: @escaping (Result<Page<CharacterModel>>) -> Void) {
        self.httpClient.request(CharacterDetailsRequest(id: id, kind: .series), completion: completion)
    }
    
    func getComics(with id: Int, completion: @escaping (Result<Page<CharacterModel>>) -> Void) {
        self.httpClient.request(CharacterDetailsRequest(id: id, kind: .comics), completion: completion)
    }
}
