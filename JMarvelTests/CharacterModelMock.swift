//
//  CharacterModelMock.swift
//  JMarvelTests
//
//  Created by Joao Marcos Ribeiro Araujo on 2/26/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
@testable import JMarvel

extension CharacterModel {
    static func mock(_ id: Int) -> CharacterModel {
        let json = """
        {
         "id": \(id),
         "name": "name\(id)"
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(CharacterModel.self, from: json)
    }
}
