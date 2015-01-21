//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Shawn Hoffman on 1/19/15.
//  Copyright (c) 2015 Shawn P Hoffman. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel: TaskModel!
    
    @IBOutlet weak var taskTextLabel: UITextField!
    @IBOutlet weak var subTaskTextLabel: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskTextLabel.text = detailTaskModel.task
        self.subTaskTextLabel.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func CancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        detailTaskModel.task =  taskTextLabel.text
        detailTaskModel.subtask = subTaskTextLabel.text
        detailTaskModel.date = dueDatePicker.date
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
