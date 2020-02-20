//
//  ImageModel.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 20/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

struct ImageModel: Decodable {
    
    enum Kind: String {
        case square = "standard_fantastic"
        case landscape = "landscape_incredible"
    }
    
    var path: String?
    var `extension`: String?
    
    func image(kind: Kind) -> URL? {
        if let path = self.path,
            let imageExtension = self.extension,
            let url = URL(string: "\(path)/\(kind.rawValue).\(imageExtension)") {
            return url
        }
        
        return nil
    }
}
