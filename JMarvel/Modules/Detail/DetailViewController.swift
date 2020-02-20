//
//  DetailViewController.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 20/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var decriptionLabel: UILabel!
    
    // MARK: - Variables
    
    var name: String?
    var image: URL?
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
    }
    
    private func setup() {
        self.decriptionLabel.text = name
        self.mainImageView.kf.setImage(with: image)
    }
}
