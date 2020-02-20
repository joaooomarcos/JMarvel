//
//  Endpoint.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

public struct Endpoint {
    var base: String?
    var path: String?
    
    public init(base: String? = nil, path: String? = nil) {
        self.base = base
        self.path = path
    }
    
    var url: String {
        (base ?? Constants.API.baseURL) + (path ?? "")
    }
}
