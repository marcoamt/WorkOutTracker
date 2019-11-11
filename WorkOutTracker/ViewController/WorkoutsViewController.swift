//
//  ViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 04/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import Firebase



class WorkoutsViewController: UIViewController{
    
    var wo : [Workout] = []
    var valueToPass: Workout = Workout(id: "", name: "", descrizione: "", exercise: [])
    @IBOutlet weak var listWorkOuts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listWorkOuts.separatorStyle = .none
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getData()
    }
    
    func getData(){
        //prendi i dati dal db
        let user = Auth.auth().currentUser

        let db = Firestore.firestore()
        db.collection("workouts").whereField("uid", isEqualTo: user!.uid).getDocuments() { (querySnapshot, err) in if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var array: [Workout] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        print("eewwwwwwwwww")
                        print(data )
                        var exArray: [Exercise] = []
                        print("exercises")
                        //let ex = data["Exercises"] as! Dictionary<String,Any>
                        let ex = data["Exercises"] as! NSMutableArray
                        for esercizio in ex{
                            //let value = esercizio.value as! Dictionary<String,Any>
                            let e = esercizio as! Dictionary<String,Any>
                            let n = e["name"] as! String
                            let r = e["reps"] as! Int
                            let s = e["sets"] as! Int
                            exArray.append(Exercise(name: n, reps: r, sets: s))
                        }
                        
                        let w = Workout(id: document.documentID, name: data["nome"] as! String, descrizione: data["descrizione"] as! String, exercise: exArray)
                        array.append(w)
                        print("workout")
                        print(w)
                        //print("\(document.documentID) => \(document.data())")
                    }
            
                    self.wo = array
                    print("Reload")
                    self.listWorkOuts.reloadData()
                    print(array)
                }
            
        }
    }
    
    
    @IBAction func unwindToListWO(sender: UIStoryboardSegue)
    {
        
        self.getData()
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        
        // Put data into the cell
        let currentW = wo[indexPath.row]
        cell.setFields(w: currentW)
        return cell
    }
    
    //vai al dettaglio del Workout
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //anadare al view controller per INIZIARE/MODIFICARE il WORKOUT
        print("You selected cell #\(indexPath.row)!")

        // Get Cell Label
        let index = tableView.indexPathForSelectedRow!
        //let currentCell = tableView.cellForRow(at: index)! as UITableViewCell
        _ = tableView.cellForRow(at: index)! as! CustomTableViewCell
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


