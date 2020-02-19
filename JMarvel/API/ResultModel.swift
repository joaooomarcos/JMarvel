//
//  ResultModel.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct ResultModel<T: Decodable>: Decodable {
    var code: Int?
    var status: String?
    var data: T?
}
