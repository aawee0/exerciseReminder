//
//  NotificationManager.swift
//  exerciseReminder
//
//  Created by ifors-comp on 12/08/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationManager {
    static let sharedManager = NotificationManager()
    
    private init() {
        
    }
    
    func createNotificationsForExercises () {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let exercises = CoreDataManager.sharedManager.fetchEntries()
        
        for index in 0..<exercises.count {
            let exercise = exercises[index]
            
            let name = exercise.value(forKey: "name")! as! String
            let date = exercise.value(forKey: "exerciseDate")! as! Date
            
            createLocalNotification(name: name, date: date)
        }
    }
    
    func createLocalNotification (name: String, date: Date) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = name
        content.body = "Please perform the exercise"
        content.categoryIdentifier = "reminder"
        content.userInfo = ["repeat": 0]
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
}
