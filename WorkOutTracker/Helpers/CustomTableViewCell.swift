//
//  CustomTableViewCell.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 02/10/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var cellView: UIView!
    
    
    func setFields(w: Workout) {
        nameLabel.text = w.name
        descLabel.text = "Descrizione"
        Utilities.styleCellView(cellView)
    }
}
