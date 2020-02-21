//
//  PosterCell.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import UIKit

class PosterCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Model
    
    private var model: PosterItem?
    
    // MARK: - Outlets

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Setup
    
    func setup(with model: PosterItem) {
        self.model = model
        self.nameLabel.text = model.title ?? ""
        self.posterImageView.kf.setImage(with: model.image?.image(kind: .portrait))
    }
}
