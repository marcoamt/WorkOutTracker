//
//  AddViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 05/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var workoutName: UITextField!
    
    var stackViewH: UIStackView = UIStackView()
    var stackViewV: UIStackView = UIStackView()
    
    var nameEntryArray: [UITextField] = []
    var setsEntryArray: [UITextField] = []
    var repsEntryArray: [UITextField] = []
    
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.backgroundColor = .cyan
        v.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        
        stackViewV = UIStackView()
        stackViewV.axis = .vertical
        stackViewV.distribution = .fillEqually
        stackViewV.alignment = .fill
        stackViewV.spacing = 10
        //stackViewV.addBackground(color: .black)
        stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackViewV)
        stackViewV.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        stackViewV.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0.0).isActive = true
        stackViewV.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0).isActive = true
        stackViewV.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -0.0).isActive = true
        stackViewV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8.0).isActive = true
        
        let newRow = createRow()
        stackViewV.addArrangedSubview(newRow)
        
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        let newRow = createRow()
        stackViewV.addArrangedSubview(newRow)
        
        /*newRow.leftAnchor.constraint(equalTo: self.stackViewV.leftAnchor, constant: 8.0).isActive = true
         newRow.topAnchor.constraint(equalTo: self.stackViewV.topAnchor, constant: 8.0).isActive = true
         newRow.rightAnchor.constraint(equalTo: self.stackViewV.rightAnchor, constant: -8.0).isActive = true
         newRow.bottomAnchor.constraint(equalTo: self.stackViewV.bottomAnchor, constant: -8.0).isActive = true*/
        
    }
    
    @IBAction func donePressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToListWO", sender: self)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToListWO" {
            let woName = workoutName.text
            let c = nameEntryArray.count
            
            var ex: [Exercise] = []
            for i in 0...c-1{
                let sets = Int(setsEntryArray[i].text ?? "") ?? 0
                let reps = Int(repsEntryArray[i].text ?? "") ?? 0
                ex.append(Exercise(name: nameEntryArray[i].text!, reps: reps, sets: sets))
            }
            
            let newWorkout = Workout(name: woName!, descrizione: "desc", exercise: ex)
            if let destinationVC = segue.destination as? WorkoutsViewController {
                destinationVC.wo.append(newWorkout)
            }
        }
    }*/
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //creazione di ogni rig con 3 caselle di testo
    func createRow() -> UIStackView{
        let nameEntry = UITextField()
        nameEntry.placeholder = "Name"
        nameEntry.delegate = self
        nameEntry.backgroundColor = .white
        nameEntry.translatesAutoresizingMaskIntoConstraints = false
        nameEntryArray.append(nameEntry)
        
        //view.addSubview(nameEntry)
        
        let setsEntry = UITextField()
        setsEntry.placeholder = "Sets"
        setsEntry.keyboardType = .numberPad
        setsEntry.delegate = self
        setsEntry.backgroundColor = .white
        setsEntry.translatesAutoresizingMaskIntoConstraints = false
        setsEntryArray.append(setsEntry)
        //view.addSubview(setsEntry)
        
        let repsEntry = UITextField()
        repsEntry.placeholder = "Reps"
        repsEntry.keyboardType = .numberPad
        repsEntry.delegate = self
        repsEntry.backgroundColor = .white
        repsEntry.translatesAutoresizingMaskIntoConstraints = false
        repsEntryArray.append(repsEntry)
        //view.addSubview(repsEntry)
        
        
        stackViewH = UIStackView()
        stackViewH.addArrangedSubview(nameEntry)
        stackViewH.addArrangedSubview(repsEntry)
        stackViewH.addArrangedSubview(setsEntry)
        stackViewH.axis = .horizontal
        stackViewH.distribution = .fillEqually
        stackViewH.alignment = .fill
        stackViewH.spacing = 10

        
        //stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        return stackViewH
    }
    
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
