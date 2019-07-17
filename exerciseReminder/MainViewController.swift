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
        
        self.tableView.register(UINib(nibName: "ExerciseMainListCell", bundle: nil), forCellReuseIdentifier: "exerciseMainListCell")
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
        self.reloadExercises()
    }
    
}

