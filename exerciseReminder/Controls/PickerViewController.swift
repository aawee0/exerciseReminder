//
//  PickerViewController.swift
//  exerciseReminder
//
//  Created by ifors-comp on 25/06/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

protocol PickerViewControllerDelegate : class {
    func didSelectDatetime(_ datetime: Date)
}

class PickerViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    var dateTime: Date?
    weak var delegate: PickerViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backgroundViewTapped(_:)) ))
        
        if let date = dateTime {
            datePickerView.setDate(date, animated: false)
        }
    }
    
    @objc func backgroundViewTapped(_ sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        delegate?.didSelectDatetime(datePickerView.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
