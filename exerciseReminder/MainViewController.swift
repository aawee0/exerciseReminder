//
//  ViewController.swift
//  exerciseReminder
//
//  Created by Evgeny Patrikeev on 23/05/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

let kTopTitleViewCornerRadius = 48

class MainViewController: UIViewController, AddExerciseViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    var exercisesArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationManager.sharedManager.createNotificationsForExercises()
        initBackgroundColor()
        
        tableView.register(UINib(nibName: "ExerciseMainListCell", bundle: nil), forCellReuseIdentifier: "exerciseMainListCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelection = false
        tableView.contentInset = UIEdgeInsets(top: headerView.frame.height - view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
        
        reloadExercises()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setRoundCornersForHeader()
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
    
    func setRoundCornersForHeader () {
        let path = UIBezierPath(roundedRect:headerView.bounds, byRoundingCorners:[.bottomLeft, .bottomRight], cornerRadii: CGSize(width: kTopTitleViewCornerRadius, height: kTopTitleViewCornerRadius))
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        headerView.layer.mask = maskLayer
        headerView.layer.masksToBounds = true
    }
    
    func reloadExercises () {
        exercisesArray = CoreDataManager.sharedManager.fetchEntryNames()
        tableView.reloadData()
    }
    
    func didCreateExercise() {
        NotificationManager.sharedManager.createNotificationsForExercises()
        reloadExercises()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
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
}
