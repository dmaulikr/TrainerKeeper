//
//  DataManager.swift
//  Kindling
//
//  Created by Mike Henry on 11/4/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class DataManager: NSObject {
    
    //MARK: - Properties
    static let sharedInstance = DataManager()
    var membersDataArray = [PFObject]()
    var classesDataArray = [PFObject]()
    var exercisesDataArray = [PFObject]()
    var workoutDataArray = [PFObject]()
    
    //MARK: - Fetch Methods
    
    func fetchMembersFromParse() {
        let fetchMembers = PFQuery(className: "Members")
        fetchMembers.addAscendingOrder("firstName")
        fetchMembers.includeKey("parent")
        fetchMembers.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
//                let firstMember = objects![6]
//                print("Class Name: \(firstMember["parent"]["groupName"])")
                print("Got Members Data")
                self.membersDataArray = objects!
//                print("Members Array: \(self.membersDataArray)")
                dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedMembersDataFromServer", object: nil))
                }
            } else {
                print("No Members Data")
            }
        }
        
    }
    
    func fetchClassesFromParse() {
        let fetchClasses = PFQuery(className: "Classes")
        fetchClasses.orderByAscending("groupName")
        fetchClasses.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Got Classes Data")
                self.classesDataArray = objects!
//                print("Classes Array: \(self.classesDataArray)")
                dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedClassesDataFromServer", object: nil))
                }
            } else {
                print("No Classes Data")
            }
        }
        
    }
    
    func fetchWorkoutDetailFromParse(member: PFObject, exercise: PFObject) {
        let fetchWorkoutDetail = PFQuery(className: "WorkoutDetail")
        fetchWorkoutDetail.whereKey("exercise", equalTo: exercise)
        fetchWorkoutDetail.whereKey("member", equalTo: member)
        fetchWorkoutDetail.orderByAscending("createdAt")
        fetchWorkoutDetail.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Got Workout Data")
                self.workoutDataArray = objects!
                print("Workout Array: \(self.workoutDataArray)")
                dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedWorkoutDataFromServer", object: nil))
                }
            } else {
                print("No Workout Data")
            }
        }
        
    }
    
    func fetchExercisesFromParse() {
        let fetchExercises = PFQuery(className: "Exercises")
        fetchExercises.orderByAscending("name")
        fetchExercises.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Got Exercises Data")
                self.exercisesDataArray = objects!
//                print("Exercises Array: \(self.exercisesDataArray)")
                dispatch_async(dispatch_get_main_queue()) {
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedExercisesDataFromServer", object: nil))
                }
            } else {
                print("No Exercises Data")
            }
        }
        
    }
        
    
}
