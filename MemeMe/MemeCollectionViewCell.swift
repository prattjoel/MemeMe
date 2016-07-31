//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Joel on 7/19/16.
//  Copyright © 2016 Joel Pratt. All rights reserved.
//

import UIKit

class MemeCollectonViewCell: UICollectionViewCell {
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var cellImage: UIImageView!
    
    
    func setLabel(topString: String, bottomString: String) {
        topLabel.text = topString
        bottomLabel.text = bottomString
        
        
    }
}
