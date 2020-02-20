//
//  Page.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct Page<T: Decodable>: Decodable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var results: [T]?
}
