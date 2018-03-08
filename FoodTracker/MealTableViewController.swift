//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Thuan on 3/8/18.
//  Copyright © 2018 Thuan. All rights reserved.
//
//  File used to store our data on class meal, keeps track via meal list

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]() //var allows meal to be mutable, add content later, no size restriction vs. let which is constant
    
    
    //this method gets called before app loads the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //turns on edit button from tableviewer
        navigationItem.leftBarButtonItem = editButtonItem
        
        //load saved data if any
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            //load test data
            loadSampleMeal()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //tells the funciton how many section to display on the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //tells the function how many rows to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    //determins which rows to display on screen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell" //identifies our cell view as constant to plug into deque func
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequed cell is not an instance of MealTableViewCell")
        }

        //grabs correct index to display from our meal array using the tableView cellForROwAt indexpath which is defined
        let meal = meals[indexPath.row]

        //set up our cell attributes
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            
            //update saved data once deleted
            saveMeals()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    
    //MARK: Action
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {

        
        
        //conditional statement that downcasts the segue source view controller because the source is type UIViewController
        //but the controller this code is on is the MealViewController
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            
        
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                //tells program we are editing and need to update tableviewcell(meal)
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                //else add a new meal to our array list
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //save users data
            saveMeals()
            
        
        }
        
    }
    
    
    
    
    
    //MARK: Private Methods
    private func loadSampleMeal() {
        
        //load images for testing
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal1")
        let photo3 = UIImage(named: "meal1")
        
        //guard makes sure code success or else goes into fataError
        guard let meal1 = Meal(name: "Chicken Dinner", photo: photo1, rating: 5) else {
            fatalError("Bug in yo code")
        }
        guard let meal2 = Meal(name: "Chicken Dinner", photo: photo2, rating: 4) else {
            fatalError("Bug in yo code")
        }
        guard let meal3 = Meal(name: "Chicken Dinner", photo: photo3, rating: 3) else {
            fatalError("Bug in yo code")
        }
        
        //now add our meals into our Meals array to keep track, since Meals is mutable
        //we can change array size as we add more meals
        meals += [meal1,meal2,meal3]
        
        
        
    }
    
    // function used to save user data when app closes
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    //function used to load user data when app opens, returns an optional [Meal] array
    private func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
    

}
