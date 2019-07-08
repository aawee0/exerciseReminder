//
//  CoreDataManager.swift
//  exerciseReminder
//
//  Created by ifors-comp on 02/07/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    
    private init() {
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "exerciseReminder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertEntry(name: String, date: Date) {
        let context = persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context)!
        let exercise = NSManagedObject(entity: entity, insertInto: context)
        
        exercise.setValue(name, forKeyPath: "name")
        exercise.setValue(date, forKeyPath: "exerciseDate")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchEntries() -> [NSManagedObject] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Exercise")
        
        var exercises = [NSManagedObject].init()
        do {
            exercises = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return exercises
    }
    
    func fetchEntryNames() -> [String] {
        let exercises = self.fetchEntries()
        var exerciseNames = [String].init()
        
        // for (int i=0; i<exercise.count; i++)
        for exercise in exercises {
            exerciseNames.insert(exercise.value(forKey: "name")! as! String, at: 0)
        }
        
        return exerciseNames
    }
}

