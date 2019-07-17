//
//  AddExerciseViewController.swift
//  exerciseReminder
//
//  Created by ifors-comp on 24/06/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

protocol AddExerciseViewControllerDelegate : class {
    func didCreateExercise()
}

class AddExerciseViewController: UIViewController, PickerViewControllerDelegate {
    
    @IBOutlet weak var timeSelectView: UIView!
    @IBOutlet weak var selectedDateLabel: UILabel!
    @IBOutlet weak var exerciseNameField: UITextField!
    
    var selectedDate: Date?
    weak var delegate: AddExerciseViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        timeSelectView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.timeSelectViewTapped(_:)) ))
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if let date = selectedDate, let name = exerciseNameField.text {
            CoreDataManager.sharedManager.insertEntry(name: name, date: date)
            self.delegate?.didCreateExercise()
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("Not enough input")
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func timeSelectViewTapped(_ sender: UITapGestureRecognizer) {
        let pickerViewController = PickerViewController.init()
        pickerViewController.delegate = self
        pickerViewController.dateTime = selectedDate
        pickerViewController.modalPresentationStyle = .overCurrentContext
        pickerViewController.modalTransitionStyle = .crossDissolve
        self.present(pickerViewController, animated: true, completion: nil)
        
    }
    
    func didSelectDatetime(_ datetime: Date) {
        print("Date:\( datetime )")
        selectedDate = datetime
        
        let format = DateFormatter()
        format.dateFormat = "dd MMM yyyy HH:mm"
        
        selectedDateLabel.text = format.string(from: datetime)
    }
    
}
