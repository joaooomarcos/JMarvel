//
//  CharacterCell.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import UIKit

class CharacterCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Variables
    
    private var model: CharacterModel?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction private func favoriteButtonTapped() { }
    
    // MARK: - Setup
    
    func setup(with character: CharacterModel) {
        self.model = character
        self.nameLabel.text = model?.name
        self.mainImageView.kf.setImage(with: model?.image?.image(kind: .square))
        
        let title = (character.isFavorited ?? false) ? "★" : "☆"
        self.favoriteButton.setTitle(title, for: .normal)
    }
}
