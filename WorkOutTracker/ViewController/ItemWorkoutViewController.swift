//
//  ItemWorkoutViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 22/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

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
        
        let numEx = passedValue.exercise.count
        
        for i in 0...numEx-1{
            let newRow = createRow(exercise: passedValue.exercise[i])
            stackViewV.addArrangedSubview(newRow)
        }
        
        let startButton = UIButton()
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        Utilities.styleHomeButton(startButton)
        
        stackViewV.addArrangedSubview(startButton)
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
        stackViewH.alignment = .fill
        stackViewH.spacing = 10

        
        //stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        return stackViewH
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


