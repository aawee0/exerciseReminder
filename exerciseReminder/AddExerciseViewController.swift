//
//  AddExerciseViewController.swift
//  exerciseReminder
//
//  Created by ifors-comp on 24/06/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController, PickerViewControllerDelegate {
    
    @IBOutlet weak var timeSelectView: UIView!
    
    var selectedDate: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        timeSelectView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.timeSelectViewTapped(_:)) ))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
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
    }
    
}
