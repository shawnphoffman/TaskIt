//
//  TaskModel.swift
//  TaskIt
//
//  Created by Shawn Hoffman on 1/20/15.
//  Copyright (c) 2015 Shawn P Hoffman. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
