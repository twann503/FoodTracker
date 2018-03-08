//
//  ViewController.swift
//  FoodTracker
//
//  Created by Thuan on 3/3/18.
//  Copyright © 2018 Thuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigns the viewcontroller delegate to nametextfield delegage
        nameTextField.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    
    //delegate handaler after user press done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //tells delegate to give up first responder. hides keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        photoImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    //MARK: Actions

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //hides keyboard if user taps on image while in keyboard
        nameTextField.resignFirstResponder()
        
        //creates variable for img picker & sets to photo libary
        let imagePickerController = UIImagePickerController()
        
        //.sourceType uses enumration of type UIImagePickerController() & sets it to photoLibary as our choice
        imagePickerController.sourceType = .photoLibrary

        //notifies viewcontroller when picture selected
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    */

}

