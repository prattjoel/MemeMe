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
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        let screenHeight = view.frame.size.height
        let screenWidth = view.frame.size.width
        let space: CGFloat = 1.0
        
        if screenHeight > screenWidth {
            flowLayoutSetup(space, height: screenHeight, width: screenWidth, size: screenWidth)
        }
        else {
            flowLayoutSetup(space, height: screenHeight, width: screenWidth, size: screenHeight)
        }
        
    }
    
    // MARK: - FlowLayout
    
    func flowLayoutSetup(space: CGFloat, height: CGFloat, width: CGFloat, size: CGFloat) {
        let divisor: CGFloat = 3.0
        let dimension = (( size - (2.0 * space)) / divisor)
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
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
        detailViewController.memeIndex = indexPath.row

        navigationController!.pushViewController(detailViewController, animated: true)

    }
    
    

    
}
