//
//  ViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 04/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController{
    
    var valueToPass: Workout = Workout(name: "", exercise: [])
    @IBOutlet weak var listWorkOuts: UITableView!
    
    var wo : [Workout] = [Workout(name: "w1", exercise: [Exercise(name: "ex1", reps: 2, sets: 2)]),
    Workout(name: "w2", exercise: [Exercise(name: "ex2", reps: 2, sets: 2)])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*self.listWorkOuts.reloadData()
        listWorkOuts.delegate = self
        listWorkOuts.dataSource = self*/
        //listWorkOuts.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //self.listWorkOuts.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        //print(Constants.Storyboard.userID)
        listWorkOuts.separatorStyle = .none
    }
    
    @IBAction func unwindToListWO(sender: UIStoryboardSegue)
    {
        /*if let sourceViewController = sender.source as? AddViewController {
            let dataRecieved = sourceViewController.newWorkout
            wo.append(dataRecieved)
        }*/
        listWorkOuts.reloadData()
        
    }
    
    
}


//Table View Data Source
extension WorkoutsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = wo[indexPath.row].name
        cell?.accessoryType = .disclosureIndicator
        return cell!*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        
        // Put data into the cell
        let currentW = wo[indexPath.row]
        cell.setFields(w: currentW)
        //print(cell.nameLabel.text as Any)
        //print(cell.descLabel.text as Any)
        return cell
    }
    
    //vai al dettaglio del Workout
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //anadare al view controller per INIZIARE/MODIFICARE il WORKOUT
        print("You selected cell #\(indexPath.row)!")

        // Get Cell Label
        let index = tableView.indexPathForSelectedRow!
        //let currentCell = tableView.cellForRow(at: index)! as UITableViewCell
        let currentCell = tableView.cellForRow(at: index)! as! CustomTableViewCell
        valueToPass = wo[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! ItemWorkoutViewController
            // your new view controller should have property that will store passed value
            viewController.passedValue = valueToPass
        }
    }

}
