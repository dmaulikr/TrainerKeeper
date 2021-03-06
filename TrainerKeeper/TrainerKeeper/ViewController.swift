//
//  ViewController.swift
//  TrainerKeeper
//
//  Created by Mike Henry on 11/30/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    //MARK: - Properties
    var dataManager = DataManager.sharedInstance
    
    
    //MARK: - Display Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = nil
    }
    
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //MOVE THESE
        dataManager.fetchMembersFromParse()
        dataManager.fetchClassesFromParse()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "TrainerKeeper"
        navigationController!.navigationBar.barTintColor = UIColor.init(red: 15/255, green: 15/255, blue: 15/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

