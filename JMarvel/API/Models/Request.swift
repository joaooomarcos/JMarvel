//
//  Request.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

public protocol Request {
    var headers: HTTPHeaders { get }
    var endpoint: Endpoint { get }
    var parameters: Parameters { get }
    var method: HTTPMethod? { get }
}

public extension Request {
    var headers: HTTPHeaders {
        [:]
    }
        
    var parameters: Parameters {
        [:]
    }
    
    var method: HTTPMethod? {
        .get
    }
}
