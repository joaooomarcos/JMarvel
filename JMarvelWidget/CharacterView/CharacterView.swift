//
//  CharacterView.swift
//  JMarvelWidget
//
//  Created by Joao Marcos Ribeiro Araujo on 2/27/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import UIKit

protocol CharacterViewDelegate: class {
    func didTap(on character: CharacterRealm)
}

class CharacterView: UIView {
    
    // MARK: - Variables
    
    private weak var delegate: CharacterViewDelegate?
    private var model: CharacterRealm?
    
    // MARK: - Outlets
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func mainButtonTapped() {
        if let model = self.model {
            self.delegate?.didTap(on: model)
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CharacterView", owner: self, options: nil)
        self.addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - Setup
    
    func setup(with character: CharacterRealm?, delegate: CharacterViewDelegate) {
        self.model = character
        self.delegate = delegate
        self.titleLabel.text = character?.name
        
        if let imageURL = character?.imageURL, !imageURL.isEmpty, let url = URL(string: imageURL) {
            self.mainImageView.kf.setImage(with: url)
        }
    }
}
