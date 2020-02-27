//
//  UICollectionView+Extensions.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 27/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Foundation
import UIKit

class JMCollectionViewController: UICollectionViewController {
    
    private var emptyMessageLabel: UILabel?
    
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
