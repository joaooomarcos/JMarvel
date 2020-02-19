//
//  ListViewController.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - Variables
    
    private var models: [CharacterModel] = []
    private let itemSize = CGSize(width: 125, height: 150)
    
    private lazy var spacing: CGFloat = {
        self.view.layoutIfNeeded()
        let numberOfColuns = (self.view.frame.width / itemSize.width).rounded(.towardZero)
        let space = self.view.frame.width.truncatingRemainder(dividingBy: itemSize.width)
        return space / (numberOfColuns + 1)
    }()

    // MARK: - Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(CharacterCell.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadData()
    }
    
    // MARK: - Data
    
    private func loadData() {
        CharacterAPI().getList { result in
            switch result {
            case .success(let page):
                self.models = page.results ?? []
                self.collectionView.reloadData()
            case .error:
                break
            }
        }
    }
}

extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCell = collectionView.dequeueReusableCell(for: indexPath)
        let model = models[indexPath.row]
        
        cell.setup(with: model)
        
        return cell
    }    
}

// MARK: - Collection View Delegate Flow Layout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }
}
