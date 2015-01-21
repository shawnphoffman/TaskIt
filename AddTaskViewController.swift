//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Shawn Hoffman on 1/20/15.
//  Copyright (c) 2015 Shawn P Hoffman. All rights reserved.
//

import CoreData
import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskLabelField: UITextField!
    @IBOutlet weak var subtaskLabelField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func CancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContect = appDelegate.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContect!)
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContect!)
        task.task = taskLabelField.text
        task.subtask = subtaskLabelField.text
        task.completed = false
        task.date = dueDatePicker.date
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContect!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
