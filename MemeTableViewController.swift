//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Joel on 7/19/16.
//  Copyright © 2016 Joel Pratt. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    @IBAction func deleteButton(sender: UIBarButtonItem) {
        setEditing(true, animated: true)
        
    }
    // MARK: - TableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applicationDelegate.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableCell", forIndexPath: indexPath)
        let meme = applicationDelegate.memes[indexPath.row]
        
        cell.textLabel?.text = meme.memeTopText
        cell.imageView!.image = meme.memedImage
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailViewController.meme = applicationDelegate.memes[indexPath.row]
        navigationController!.pushViewController(detailViewController, animated: true)
    }

    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           applicationDelegate.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    
    }
    
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
}

