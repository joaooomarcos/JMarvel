//
//  CharacterCell.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import UIKit

protocol CharacterCellActionDelegate: class {
    func didTapFavorite(_ model: CharacterModel)
}

class CharacterCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Variables
    
    private var model: CharacterModel?
    private weak var delegate: CharacterCellActionDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction private func favoriteButtonTapped() {
        guard let model = self.model else { return }
        model.isFavorited.toggle()
        self.updateLayout()
        self.delegate?.didTapFavorite(model)
    }
    
    // MARK: - Setup
    
    func setup(with character: CharacterModel, delegate: CharacterCellActionDelegate? = nil) {
        self.model = character
        self.delegate = delegate
        self.nameLabel.text = model?.name
        self.mainImageView.kf.setImage(with: model?.image?.image(kind: .square))
        self.updateLayout()
    }
    
    func setup(with character: CharacterRealm) {
        self.nameLabel.text = character.name ?? ""
        if let url = URL(string: character.imageURL ?? "") {
            self.mainImageView.kf.setImage(with: url)
        }
        self.favoriteButton.isHidden = true
    }
    
    func updateLayout() {
        let image = (self.model?.isFavorited ?? false) ? #imageLiteral(resourceName: "iconStarFilled") : #imageLiteral(resourceName: "iconStar")
        self.favoriteButton.setImage(image, for: .normal)
    }
}
