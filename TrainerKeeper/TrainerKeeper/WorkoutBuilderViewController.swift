//
//  WorkoutBuilderViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 12/3/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class WorkoutBuilderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    @IBOutlet weak var workoutNameTextField     :UITextField!
    @IBOutlet weak var workoutBuilderTableView  :UITableView!
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.exercisesDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let classCell = tableView.dequeueReusableCellWithIdentifier("workoutBuilderCell", forIndexPath:
            indexPath) as UITableViewCell
        let currentExercise = dataManager.exercisesDataArray[indexPath.row]
        classCell.textLabel!.text = "\(currentExercise["name"] as! String!)"
        
        return classCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = workoutBuilderTableView.cellForRowAtIndexPath(indexPath)
        if selectedCell!.selected == true {
            selectedCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = workoutBuilderTableView.cellForRowAtIndexPath(indexPath)
        if selectedCell!.selected == false {
            selectedCell?.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let memberToDelete = dataManager.exercisesDataArray[indexPath.row]
            memberToDelete.deleteInBackground()
            dataManager.fetchExercisesFromParse()
        }
    }
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        if let indexPaths = workoutBuilderTableView.indexPathsForSelectedRows {
//            print(indexPaths)
            let newWorkout = PFObject(className: "WorkoutMaster")
            newWorkout["workoutName"] = workoutNameTextField.text
            newWorkout.saveInBackground()
            for indexPath in indexPaths {
                let selectedExercise = dataManager.exercisesDataArray[indexPath.row]
                let newWorkoutDetail = PFObject(className: "WorkoutDetail")
                newWorkoutDetail["exerciseName"] = selectedExercise
                newWorkoutDetail["parent"] = newWorkout
                newWorkoutDetail.saveInBackground()
            }
        }

    
    }


    func newExercisesDataReceived() {
        workoutBuilderTableView.reloadData()
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.fetchExercisesFromParse()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newExercisesDataReceived", name: "receivedExercisesDataFromServer", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
