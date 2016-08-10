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
    
    override func editButtonItem() -> UIBarButtonItem {
        super.editButtonItem()
        
        
        return editButtonItem()
    }
    
    @IBAction func editImage(sender: UIBarButtonItem) {
        editButtonItem()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
        let deleteButton: UIBarButtonItem = UIBarButtonItem(title: "Delete", style: .Plain, target: self, action: "deleteImage:")
        let editButton: UIBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editMeme:")
        
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
        
    }
    
    func deleteImage(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Are you sure you want to delete this Meme?", message: "", preferredStyle: .Alert)
        
        func alertActionSetup(title: String, style: UIAlertActionStyle) {
            let deleteButtonAction = UIAlertAction(title: title, style: style, handler: {
                action in
                
                if title == "Delete" {
                    self.deleteMeme()
                }
                else if title == "Cancel" {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            )
            alertController.addAction(deleteButtonAction)
        }
        
        alertActionSetup("Delete", style: .Destructive)
        alertActionSetup("Cancel", style: .Cancel)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func deleteMeme() {
        var memes = applicationDelegate.memes
        for (index, value) in memes.enumerate() {
            print("index: \(index), value \(value)")
            if value.memeTopText == meme.memeTopText && value.memeBottomText == meme.memeBottomText {
                print("The current index is: \(index)")
                memes.removeAtIndex(index)
                print(memes.count)
            }
        }
        
        print(memes.count)
        
        
        dismissViewControllerAnimated(true, completion: nil)
        let sentMemesVC = storyboard!.instantiateViewControllerWithIdentifier("MemeTableViewController") as! MemeTableViewController
        sentMemesVC.applicationDelegate.memes = memes
        navigationController?.pushViewController(sentMemesVC, animated: true)
    }
    
    func editMeme(sender: UIButton) {
        
        let memeEditorVC = storyboard!.instantiateViewControllerWithIdentifier("MemeEditorVC") as! MemeEditorVC
        memeEditorVC.meme = meme
        navigationController?.pushViewController(memeEditorVC, animated: true)
        
    }
}