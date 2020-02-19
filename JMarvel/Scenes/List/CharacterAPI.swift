//
//  CharacterAPI.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharacterAPI {
    
    // MARK: - Variables
    
    private var httpClient: HTTPClient
    
    // MARK: - Init
    
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    // MARK: - Public
    
    func getList(completion: @escaping (Result<Page<CharacterModel>>) -> Void) {
        self.httpClient.request(CharactersRequest(), completion: completion)
    }
}
