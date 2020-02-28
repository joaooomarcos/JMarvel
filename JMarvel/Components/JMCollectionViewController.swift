//
//  UICollectionView+Extensions.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 27/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

class JMCollectionViewController: UICollectionViewController {
    
    private var emptyMessageLabel: UILabel?
    
    var itemSize: CGSize = .zero
    var itemSpacing: CGFloat = .zero
    
    func setEmptyMessage(_ message: String) {
        guard emptyMessageLabel == nil else {
            self.emptyMessageLabel?.text = message
            return
        }
        
        self.emptyMessageLabel = UILabel(frame: CGRect.zero)
        self.emptyMessageLabel?.text = message
        self.emptyMessageLabel?.textColor = .systemGray
        self.emptyMessageLabel?.numberOfLines = 0
        self.emptyMessageLabel?.textAlignment = .center
        self.emptyMessageLabel?.sizeToFit()
        self.emptyMessageLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        if let label = emptyMessageLabel {
            self.collectionView.addSubview(label)
            
            label.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: self.collectionView.trailingAnchor, constant: 16).isActive = true
            label.leadingAnchor.constraint(equalTo: self.collectionView.leadingAnchor, constant: 16).isActive = true
            label.topAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: 32).isActive = true
        }
    }
    
    func removeEmptyMessage() {
        self.emptyMessageLabel?.removeFromSuperview()
        self.emptyMessageLabel = nil
    }
}

extension JMCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.itemSpacing,
                            left: self.itemSpacing,
                            bottom: self.itemSpacing,
                            right: self.itemSpacing)
    }
}
