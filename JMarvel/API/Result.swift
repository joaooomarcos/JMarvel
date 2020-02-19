//
//  Result.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case error(GenericError)
}
