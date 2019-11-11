//
//  ItemWorkoutViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 22/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import Firebase

class ItemWorkoutViewController: UIViewController, UITextFieldDelegate {

    var passedValue: Workout = Workout(name: "", descrizione: "desc", exercise: [])
    
    @IBOutlet weak var nav: UINavigationItem!
    var stackViewH: UIStackView = UIStackView()
    var stackViewV: UIStackView = UIStackView()
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.backgroundColor = .cyan
        v.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        return v
    }()
    
    @IBOutlet weak var navBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cambio il nome del titolo della navigation bar
        nav.title =  passedValue.name
        
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
        
        let nameLabel = UILabel()
        nameLabel.text = "Exercise"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let setsLabel = UILabel()
        setsLabel.text = "Sets"
        setsLabel.textAlignment = .center
        setsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        setsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let repsLabel = UILabel()
        repsLabel.text = "Reps"
        repsLabel.textAlignment = .center
        repsLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewH = UIStackView()
        stackViewH.addArrangedSubview(nameLabel)
        stackViewH.addArrangedSubview(repsLabel)
        stackViewH.addArrangedSubview(setsLabel)
        stackViewH.axis = .horizontal
        stackViewH.distribution = .fillEqually
        stackViewH.alignment = .center
        stackViewH.spacing = 10
        stackViewV.addArrangedSubview(stackViewH)
        
        let numEx = passedValue.exercise.count
        
        for i in 0...numEx-1{
            let newRow = createRow(exercise: passedValue.exercise[i])
            stackViewV.addArrangedSubview(newRow)
        }
        
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.addTarget(self, action: #selector(self.startPressed(_:)), for: .touchUpInside)
        Utilities.styleHomeButton(startButton)
        
        stackViewV.addArrangedSubview(startButton)
        
        let deleteButton = UIButton()
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.addTarget(self, action: #selector(self.deletePressed(_:)), for: .touchUpInside)
        Utilities.styleHomeButton(deleteButton)
        
        stackViewV.addArrangedSubview(deleteButton)
    }
    
    @IBAction func startPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Aggiungere alla lista?", message: "Sicuro di voler aggiungere questo workout alla tua cronologia", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        let user = Auth.auth().currentUser
                                        let db = Firestore.firestore()
                                        db.collection("workoutsDone").addDocument(data: [
                                            "idWorkout" : self.passedValue.id,
                                            "idUser" : user!.uid,
                                            "date" : Date()
                                        ]) { err in
                                                if let err = err {
                                                    print("Error adding document: \(err)")
                                                } else {
                                                    
                                                    print("ok")
                                                }
                                        }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Cancellare workout?", message: "Sicuro di voler cancellare questo workout dalla tua scheda", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .destructive,
                                      handler: {(_: UIAlertAction!) in
                                        let db = Firestore.firestore()
                                        db.collection("workouts").document(self.passedValue.id).delete() { err in
                                                if let err = err {
                                                    print("Error adding document: \(err)")
                                                } else {
                                                    
                                                    print("ok")
                                                }
                                        }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func createRow(exercise: Exercise) -> UIStackView{
        
        let nameLabel = UILabel()
        nameLabel.text = exercise.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let setsLabel = UILabel()
        setsLabel.text = String(exercise.sets)
        setsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let repsLabel = UILabel()
        repsLabel.text = String(exercise.reps)
        repsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewH = UIStackView()
        stackViewH.addArrangedSubview(nameLabel)
        stackViewH.addArrangedSubview(repsLabel)
        stackViewH.addArrangedSubview(setsLabel)
        stackViewH.axis = .horizontal
        stackViewH.distribution = .fillEqually
        stackViewH.alignment = .center
        stackViewH.spacing = 10

        
        //stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        return stackViewH
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


