//
//  File.swift
//  Marvel
//
//  Created by Alper Akinci on 28/12/2017.
//  Copyright © 2017 Alper Akinci. All rights reserved.
//

import Foundation
import UIKit

class ImageCell : UICollectionViewCell {

    @IBOutlet var imageView: UIImageView?

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.layer.backgroundColor = UIColor.lightGray.cgColor
            }else {
                self.layer.backgroundColor = UIColor.clear.cgColor
            }
        }
    }
}
