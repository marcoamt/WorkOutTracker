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
    
    @IBOutlet weak var descTextView: UITextView!
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
        Utilities.styleAddTextField(workoutName)
        descTextView.layer.borderWidth = 1
        descTextView.layer.borderColor = UIColor.black.cgColor
        descTextView.layer.cornerRadius = 10.0
        
        self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 280.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0).isActive = true
        
        stackViewV = UIStackView()
        stackViewV.axis = .vertical
        stackViewV.distribution = .fillEqually
        stackViewV.alignment = .fill
        stackViewV.spacing = 20
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
    
    @IBAction func stepper(_ sender: UIStepper) {
        print("stepper: " + String(sender.value))
        if(nameEntryArray.count-1 <= Int(sender.value)){
            let newRow = createRow()
            stackViewV.addArrangedSubview(newRow)
        } else{
            deleteRow()
        }
        print("rows: " + String(nameEntryArray.count))
    }
    
    @IBAction func donePressed(_ sender: Any) {
        let name = workoutName.text
        let desc = descTextView.text
        var exArray: [Exercise] = []
        for i in 0 ..< nameEntryArray.count{
            exArray.append(Exercise(name: nameEntryArray[i].text!, reps: Int(repsEntryArray[i].text!)!, sets: Int(setsEntryArray[i].text!)!))
        }
        let newWorkout = Workout(name: name!, descrizione: desc!, exercise: exArray)
        
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        
        
        
        //let dic: Dictionary<String, Any> = newWorkout.exercise.toDictionary{$0.name}
        
        var dic: Dictionary<String, Any> = [:]
        let f = newWorkout.exercise.compactMap { (Exercise) -> Dictionary<String, Any>? in
            
            dic["name"] = Exercise.name
            dic["reps"] = Exercise.reps
            dic["sets"] = Exercise.sets
            return dic
        }
        
        print(f)
        
        db.collection("workouts").addDocument(data: [
            "nome" : newWorkout.name,
            "descrizione": newWorkout.descrizione,
            "Exercises": f,
            "uid": user!.uid
        ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("ok")
                }
        }
        
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
        nameEntry.delegate = self
        Utilities.styleAddTextField(nameEntry)
        nameEntry.placeholder = "Name"
        nameEntryArray.append(nameEntry)
        
        //view.addSubview(nameEntry)
        
        let setsEntry = UITextField()
        setsEntry.delegate = self
        Utilities.styleAddTextField(setsEntry)
        setsEntry.placeholder = "Sets"
        setsEntry.keyboardType = .numberPad
        setsEntryArray.append(setsEntry)
        //view.addSubview(setsEntry)
        
        let repsEntry = UITextField()
        repsEntry.delegate = self
        Utilities.styleAddTextField(repsEntry)
        repsEntry.placeholder = "Reps"
        repsEntry.keyboardType = .numberPad
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
    
    func deleteRow() {
        let lastId = nameEntryArray.count-1
        nameEntryArray.remove(at: lastId)
        repsEntryArray.remove(at: lastId)
        setsEntryArray.remove(at: lastId)
        stackViewV.arrangedSubviews[lastId].removeFromSuperview()
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

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
extension Dictionary {
    public func toMap<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
