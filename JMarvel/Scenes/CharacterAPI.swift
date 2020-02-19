//
//  CharacterAPI.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class CharacterAPI {
    func getList(completion: @escaping (Result<Page<CharacterModel>>) -> Void) {
        HTTPClient().request(CharactersRequest(), completion: completion)
    }
}
