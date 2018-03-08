//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Thuan on 3/8/18.
//  Copyright © 2018 Thuan. All rights reserved.
//
//  File used to store our data on class meal, keeps track via meal list

import UIKit

class MealTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]() //var allows meal to be mutable, add content later, no size restriction vs. let which is constant
    
    
    //this method gets called before app loads the view
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeal()

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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
    

}
