//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Joel on 7/20/16.
//  Copyright © 2016 Joel Pratt. All rights reserved.
//

import UIKit

// Shows completed memes when selected
class MemeDetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var meme = Meme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = meme.memedImage
    }
}