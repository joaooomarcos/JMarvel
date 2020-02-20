//
//  ImageModel.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 20/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct ImageModel: Decodable {
    var path: String?
    var `extension`: String?
    
    var thumbURL: URL? {
        if let path = self.path,
            let imageExtension = self.extension,
            let url = URL(string: "\(path)/standard_fantastic.\(imageExtension)") {
            return url
        }
        
        return nil
    }
}
