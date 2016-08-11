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
    
    let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var meme = Meme()
    var memeIndex: Int?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "Delete", style: .Plain, target: self, action: "deleteMeme:")
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme:")
        
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
        
    }
    
    // MARK: - Delete and edit methods
    func deleteMeme(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Are you sure you want to delete this Meme?", message: "", preferredStyle: .Alert)
        
        func alertActionSetup(title: String, style: UIAlertActionStyle) {
            let deleteButtonAction = UIAlertAction(title: title, style: style, handler: {
                action in
                
                if title == "Delete" {
                    self.removeMeme()
                }
                else if title == "Cancel" {
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                }
                }
            )
            alertController.addAction(deleteButtonAction)
        }
        
        alertActionSetup("Delete", style: .Destructive)
        alertActionSetup("Cancel", style: .Cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // Removes Meme object from Memes array
    
    func removeMeme() {
        var memes = applicationDelegate.memes
        if let index = memeIndex {
            memes.removeAtIndex(index)
        }
        
        let sentMemesVC = storyboard!.instantiateViewControllerWithIdentifier("MemeTableViewController") as! MemeTableViewController
        sentMemesVC.applicationDelegate.memes = memes
        navigationController?.pushViewController(sentMemesVC, animated: true)
    }
    
    // Presents Meme Editor
    func editMeme(sender: UIButton) {
        let memeEditorVC = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorVC") as! MemeEditorVC
        memeEditorVC.memeToEdit = meme
        memeEditorVC.memeIndex = memeIndex
        
        presentViewController(memeEditorVC, animated: true, completion: nil)
        navigationController?.popViewControllerAnimated(true)
    }
}