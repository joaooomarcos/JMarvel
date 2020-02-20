//
//  ReusableView.swift
//  JMarvel
//
//  Created by Joao Marcos Ribeiro Araujo on 19/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import UIKit

protocol NibLoadName: class {
    static var nibName: String { get }
}

extension NibLoadName where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

protocol ReusableIdentifier: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableIdentifier where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

protocol ReusableView: NibLoadName, ReusableIdentifier { }

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableIdentifier {
        self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableIdentifier {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
