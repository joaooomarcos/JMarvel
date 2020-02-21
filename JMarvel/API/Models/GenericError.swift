//
//  GenericError.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

public class GenericError: Codable, Error {
    public var statusCode: Int
    public var message: String

    init(message: String, statusCode: Int = -1) {
        self.message = message
        self.statusCode = statusCode
    }
    
    convenience init(error: Error, statusCode: Int = -1) {
        self.init(message: error.localizedDescription, statusCode: statusCode)
    }
    
    convenience init<T>(result: ResultModel<T>) {
        self.init(message: result.status ?? "", statusCode: result.code ?? -1)
    }
}
