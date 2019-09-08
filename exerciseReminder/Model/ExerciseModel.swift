//
//  ExerciseModel.swift
//  exerciseReminder
//
//  Created by Evgeny Patrikeev on 08/09/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

class ExerciseModel: NSObject {
    var exerciseDate: Date?
    var name: String?
    
    init(name: String, date: Date) {
        self.name = name
        self.exerciseDate = date
    }
}
