//
//  CharacterDetailsViewController.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 20/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import UIKit

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Presenter
    
    var presenter: CharacterDetailsPresenterInputProtocol!
    
    // MARK: - Variables
    
    private var series: [CharacterModel] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var decriptionLabel: UILabel!
    @IBOutlet private weak var seriesCollectionView: UICollectionView!
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadData()
        self.setupCollectionView()
    }
    
    // MARK: - Setups
    
    private func setupCollectionView() {
        self.seriesCollectionView.register(CharacterCell.self)
        self.seriesCollectionView.dataSource = self
    }
}

// MARK: - Collection View Data Source

extension CharacterDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.series.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath)
        let model = self.series[indexPath.row]
        
        cell.setup(with: model)
        
        return cell
    }
}

// MARK: - Presenter Output

extension CharacterDetailsViewController: CharacterDetailsPresenterOutputProtocol {
    func didGet(imageURL: URL?, description: String) {
        self.mainImageView.kf.setImage(with: imageURL)
        self.decriptionLabel.text = description
    }
    
    func didGet(series items: [CharacterModel]) {
        self.series = items
        self.seriesCollectionView.reloadData()
    }
    
    func didGet(comics items: [CharacterModel]) { }
}
