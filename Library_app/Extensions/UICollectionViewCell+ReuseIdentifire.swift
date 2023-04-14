//
//  UICollectionViewCell+ReuseIdentifire.swift
//  Library_app
//
//  Created by Maksim Matveichuk on 13.04.23.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}
