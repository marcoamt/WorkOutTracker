//
//  ViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 04/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController {

    @IBOutlet weak var listWorkOuts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        caricaWO()
    }

    func caricaWO() {
        let wo = ["ex1", "ex2", "ex3"]
       
        let indexPath = IndexPath(row: wo.count - 1, section: 0)
        listWorkOuts.beginUpdates()
        listWorkOuts.insertRows(at: [indexPath], with: .automatic)
        listWorkOuts.endUpdates()
    }
}
