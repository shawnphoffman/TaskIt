//
//  ViewController.swift
//  TaskIt
//
//  Created by Shawn Hoffman on 1/15/15.
//  Copyright (c) 2015 Shawn P Hoffman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        var cell: TaskTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
        cell.taskLabel.text = thisTask.task
        cell.subtaskLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        return cell
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.detailTaskModel = thisTask
        } else if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
        }
    }
    
    @IBAction func addTaskTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To do"
        }
        else {
            return "Completed"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            thisTask.completed = true
        }
        else {
            thisTask.completed = false
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // Helper function
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest =  NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchedResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: "completed", cacheName: nil)
        
        return fetchedResultsController
    }
    
}

