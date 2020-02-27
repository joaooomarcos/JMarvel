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
    
    private var series: [PosterItem] = []
    private var comics: [PosterItem] = []
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var decriptionLabel: UILabel!
    @IBOutlet private weak var seriesView: UIView!
    @IBOutlet private weak var comicsView: UIView!
    @IBOutlet private weak var seriesCollectionView: UICollectionView!
    @IBOutlet private weak var comicsCollectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        self.presenter.didTapFavorite()
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.loadData()
        self.setupCollectionView()
    }
    
    // MARK: - Privates
    
    private func setupCollectionView() {
        self.seriesCollectionView.register(PosterCell.self)
        self.comicsCollectionView.register(PosterCell.self)
        self.seriesCollectionView.dataSource = self
        self.comicsCollectionView.dataSource = self
    }
}

// MARK: - Collection View Data Source

extension CharacterDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case seriesCollectionView:
            return self.series.count
        case comicsCollectionView:
            return self.comics.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PosterCell = collectionView.dequeueReusableCell(for: indexPath)
        let model: PosterItem
        
        switch collectionView {
        case seriesCollectionView:
            model = self.series[indexPath.row]
        default:
            model = self.comics[indexPath.row]
        }
        
        cell.setup(with: model)
        
        return cell
    }
}

// MARK: - Presenter Output

extension CharacterDetailsViewController: CharacterDetailsPresenterOutputProtocol {
    func updateLayout(isFavorited: Bool) {
        let image = isFavorited ? #imageLiteral(resourceName: "iconStarFilled") : #imageLiteral(resourceName: "iconStar")
        self.favoriteButton.setImage(image, for: .normal)
    }
    
    func prepareLayout(seriesIsHidden: Bool, comicsIsHidden: Bool) {
        self.seriesView.isHidden = seriesIsHidden
        self.comicsView.isHidden = comicsIsHidden
    }
    
    func didGet(imageURL: URL?, description: String) {
        self.mainImageView.kf.setImage(with: imageURL)
        self.decriptionLabel.text = description
    }
    
    func didGet(series items: [PosterItem]) {
        self.series = items
        self.seriesCollectionView.reloadData()
    }
    
    func didGet(comics items: [PosterItem]) {
        self.comics = items
        self.comicsCollectionView.reloadData()
    }
    
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showAlert(title: String, message: String) {
        self.showSimpleAlert(title: title, message: message)
    }
}
