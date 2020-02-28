//
//  PosterItem.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation

class PosterItem: Decodable {
    
    var id: Int
    var title: String?
    var image: ImageModel?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image = "thumbnail"
    }
}
