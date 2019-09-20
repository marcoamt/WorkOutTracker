//
//  ViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 04/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController{
    
    @IBOutlet weak var listWorkOuts: UITableView!
    
    var wo : [Workout] = [Workout(name: "w1", exercise: [Exercise(name: "ex1", reps: 2, sets: 2)]),
    Workout(name: "w2", exercise: [Exercise(name: "ex2", reps: 2, sets: 2)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.listWorkOuts.reloadData()
        listWorkOuts.delegate = self
        listWorkOuts.dataSource = self
        listWorkOuts.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
}

extension WorkoutsViewController: UITableViewDelegate {
    
}

//Table View Data Source
extension WorkoutsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = wo[indexPath.row].name
        return cell!
    }
    
}
