//
//  ViewController.swift
//  exerciseReminder
//
//  Created by Evgeny Patrikeev on 23/05/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddExerciseViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var exercisesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackgroundColor()
        
        self.tableView.register(UINib(nibName: "ExerciseMainListCell", bundle: nil), forCellReuseIdentifier: "exerciseMainListCell")
        
        NotificationManager.sharedManager.createNotificationsForExercises()
        self.reloadExercises()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "addExerciseVC" {
            let destination = segue.destination as! AddExerciseViewController
            destination.delegate = self
        }
    }
    
    func initBackgroundColor () {
        let colorTop = UIColor(red: 245.0 / 255.0, green: 160.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 233.0 / 255.0, green: 70.0 / 255.0, blue: 22.0 / 255.0, alpha: 1.0).cgColor
        
        let gl = CAGradientLayer()
        gl.colors = [colorTop, colorBottom]
        gl.locations = [0.0, 1.0]
        
        view.backgroundColor = UIColor.clear
        gl.frame = view.bounds
        view.layer.insertSublayer(gl, at: 0)
    }
    
    func reloadExercises () {
        exercisesArray = CoreDataManager.sharedManager.fetchEntryNames()
        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseMainListCell") as! ExerciseMainListCell
        
        print(" cell: \(cell) + \(String(describing: cell.titleLabel.text)) ")
        cell.titleLabel.text = exercisesArray[indexPath.row]
        
        return cell
    }
    
    func didCreateExercise() {
        NotificationManager.sharedManager.createNotificationsForExercises()
        self.reloadExercises()
    }
    
}

