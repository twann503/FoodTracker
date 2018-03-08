//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Thuan on 3/3/18.
//  Copyright © 2018 Thuan. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancel(_ sender: Any) {
        
        //creates consant that is a boolean value checking if the viewcontroller is exiting or editing
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //assigns the viewcontroller delegate to nametextfield delegage
        nameTextField.delegate = self
        
        // loads our view if editing a meal
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        //disable save button if no text is entered
        updateSaveButtonState()
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    
    
    //delegate handaler after user press done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //tells delegate to give up first responder. hides keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //enable button once user hits done on keyboard
        updateSaveButtonState()
        
        //sets navigation title to entered text in field
        navigationItem.title = textField.text
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
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem , button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //gets values and load into constants
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //pass constants into meal object so segue can pass back to viewtablecontroller
        meal = Meal(name: name, photo: photo, rating: rating)
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
    
    //MARK: Private Functions
    
    private func updateSaveButtonState() {
        //Disable Save Button if textfield is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }

}

