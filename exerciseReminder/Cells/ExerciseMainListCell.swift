//
//  ExerciseMainListCell.swift
//  exerciseReminder
//
//  Created by Evgeny Patrikeev on 23/05/2019.
//  Copyright © 2019 Evgeny Patrikeev. All rights reserved.
//

import UIKit

class ExerciseMainListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roundCornerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundCornerView.layer.borderColor = UIColor.init(red: 10.0/255.0, green: 10.0/255.0, blue: 10.0/255.0, alpha: 1.0).cgColor
        self.roundCornerView.layer.borderWidth = 0.5
        self.roundCornerView.layer.cornerRadius = 8
        self.roundCornerView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
