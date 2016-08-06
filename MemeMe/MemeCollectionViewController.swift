//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Joel on 7/19/16.
//  Copyright © 2016 Joel Pratt. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    // MARK: CollectionView DataSource
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectonViewCell
        
        let meme = memes[indexPath.row]
        cell.cellImage.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailViewController, animated: true)

    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenHeight = view.frame.size.height
        let screenWidth = view.frame.size.width
        let spacePortrait: CGFloat = 1.0
        let spaceLandscape: CGFloat = 1.0
        
        print(screenHeight)
        print(screenWidth)
        
        
        if screenHeight > screenWidth {
            flowLayoutSetup(spacePortrait, height: screenHeight, width: screenWidth, size: screenWidth)
        }
        else {
            flowLayoutSetup(spaceLandscape, height: screenHeight, width: screenWidth, size: screenHeight)
        }
        
        
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        
    }
    
    // MARK: - FlowLayout
    
    func flowLayoutSetup(space: CGFloat, height: CGFloat, width: CGFloat, size: CGFloat) {
        var divisor: CGFloat = 3.0
        
        while Int(height) % Int(divisor) != 0 && Int(width) % Int(divisor) != 0 {
            divisor += 0.1
            print(divisor)
        }
        let dimension = (( size - (2.0 * space)) / divisor)
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
}
