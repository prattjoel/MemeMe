//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Joel on 7/19/16.
//  Copyright © 2016 Joel Pratt. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
}
