//
//  Constants.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 18/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

enum Constants {
    enum API {
        static let baseURL = "https://gateway.marvel.com:443/v1"
        static let publicKey = "335167f60eaf6829d0daf9939cb86da7"
        static let privateKey = "82355a6e9864b5a5a09717b484f76c3ee11ca9de"
    }
    
    enum Dimensions {
        static let spacing: CGFloat = 16.0
        static let minItemSize = CGSize(width: 200, height: 225)
    }
}
