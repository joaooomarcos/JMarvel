//
//  SizeHelper.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 27/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class SizeHelper {
    
    private let spacing: CGFloat
    private let minItemSize: CGSize
    
    init(minItemSize: CGSize = Constants.Dimensions.minItemSize,
        spacing: CGFloat = Constants.Dimensions.spacing) {
        self.minItemSize = minItemSize
        self.spacing = spacing
    }
    
    func itemSize(for width: CGFloat) -> CGSize {
        let utilWidth = width - 2 * self.spacing
        let itemsPerRow = round(utilWidth / self.minItemSize.width)
        
        let itemWidth = (utilWidth - ((itemsPerRow - 1) * self.spacing)) / itemsPerRow
        
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        return itemSize
    }
}
