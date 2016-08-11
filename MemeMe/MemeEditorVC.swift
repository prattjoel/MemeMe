//
//  ViewController.swift
//  memeMeVersion1
//
//  Created by Joel on 4/9/16.
//  Copyright © 2016 Joel. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    // Buttons to select image
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var photoLibraryButton: UIBarButtonItem!
    
    // Meme TextFields
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    // Toolbar and Navbar with shar and cancel buttons
    @IBOutlet weak var imageToolbar: UIToolbar!
    @IBOutlet weak var shareNavBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // Image views
    @IBOutlet weak var imagePickerView: UIImageView!
    
    // Prompt to create meme
    @IBOutlet weak var selectImagePrompt: UILabel!
    
    // Mark: - Variable/Constants
    var memeToEdit = Meme()
    var memeDetailVC = MemeDetailViewController()
    var memeIndex: Int!
    
    // Sets attributes for text fields
    var memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "impact", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if memeToEdit.memeTopText != nil && memeToEdit.memeBottomText != nil {
            imagePickerView.image = memeToEdit.image
            topText.text = memeToEdit.memeTopText
            bottomText.text = memeToEdit.memeBottomText
            textSetup()
        }
        else {
            textSetup()
            
            selectImagePrompt.text = "Select an Image to Create a Meme"
            selectImagePrompt.textColor = UIColor.blackColor()
        }
        
    }
    
    // Disables camera button, share button, and cancel button.  Also hides prompt to create meme
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        shareButton.enabled = imagePickerView.image != nil
        cancelButton.enabled = true
        selectImagePrompt.hidden = imagePickerView.image != nil
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    // MARK: - TextField Setup
    
    func prepareTextField (textField: UITextField, defaultText: String){
        
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        if textField.text == "" {
            textField.text = defaultText
        }
        textField.autocapitalizationType = .AllCharacters
        textField.textAlignment = .Center
        
    }
    
    // Sets up textfields
    func textSetup (){
        prepareTextField(topText, defaultText: "TOP")
        prepareTextField(bottomText, defaultText: "BOTTOM")
    }
    
    
    // Clears textfields when user begins editing
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    
    // Allows user to choose font type
    @IBAction func choooseFontType (sender: AnyObject){
        
        func changeFontName (fontNameChosen: String) {
            
            let fontType: String = fontNameChosen
            memeTextAttributes[NSFontAttributeName] = UIFont(name: fontType, size: 40)!
            textSetup()
        }
        
        let alertController = UIAlertController(title: "Pick Your Meme Font", message: "", preferredStyle: .ActionSheet)
        
        func alertControllerActionSetup(title: String, style: UIAlertActionStyle, fontName: String?) {
            
            let fontAction = UIAlertAction(title: title, style: style, handler: {
                action in
                
                if let name = fontName {
                    changeFontName(name)
                }
                else {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                }
            )
            
            alertController.addAction(fontAction)
        }
        
        alertControllerActionSetup("Impact (Default)", style: .Default, fontName: "Impact")
        alertControllerActionSetup("Times New Roman", style: .Default, fontName: "Times New Roman")
        alertControllerActionSetup("Helvetica Neue", style: .Default, fontName: "Helvetica Neue")
        alertControllerActionSetup("Marker Felt", style: .Default, fontName: "Marker Felt")
        alertControllerActionSetup("Cancel", style: .Cancel, fontName: nil)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Keybord Setup/Functionality
    
    
    // Subscribes to keyboard notifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:" , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Unsubscribes from keyboard notifications
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    // Shows keyboard
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.isFirstResponder(){
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // Hides keyboard
    func keyboardWillHide (notification: NSNotification){
        if bottomText.isFirstResponder(){
            view.frame.origin.y = 0
        }
    }
    
    // Gets keyboard height for showing and hiding it without blocking textfield
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // Dismisses keyboard when return is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
        
        if topText.text == "" {
            topText.text = "TOP"
        }
        if bottomText.text == "" {
            bottomText.text = "BOTTOM"
        }
        
        return true
    }
    
    // MARK: - Image Setup/Actions
    
    // Allows image view to display images from UIImagePickerController
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func chooseImageFromSourceType(source: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    // Allows user to choose image from album
    @IBAction func pickAnImage(sender: AnyObject) {
        chooseImageFromSourceType(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    
    // Allows user to choose image using camera
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        chooseImageFromSourceType(UIImagePickerControllerSourceType.Camera)
    }
    
    
    
    // MARK: - Meme Creation
    
    // Saves Meme
    func save(newMemedImage : UIImage) {
        
        let meme = Meme(memeTopText: topText.text!, memeBottomText: bottomText.text!, image: imagePickerView.image, memedImage: newMemedImage)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        if memeToEdit.memeTopText == nil {
            appDelegate.memes.append(meme)
        }
        else {
            appDelegate.memes[memeIndex] = meme
            
        }
    }
    
    // Creates a UIImage that combines the Image View and the Textfields
    func generateMemedImage() -> UIImage {
        
        imageToolbar.hidden = true
        shareNavBar.hidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        self.view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageToolbar.hidden = false
        shareNavBar.hidden = false
        return memedImage
    }
    
    // Allows user to share created Meme
    @IBAction func shareMemeImage(sender: UIBarButtonItem) {
        
        let memeToShare = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memeToShare as UIImage], applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { (activty, completed, items, error) in
            if completed{
                self.save(memeToShare)
                let sentMemesController = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController")
                self.presentViewController(sentMemesController, animated: true, completion: nil)
            }
        }
    }
    
    // Allows user to start over
    @IBAction func cancelMeme(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}

