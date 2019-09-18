//
//  AddViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 05/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var workoutName: UITextField!
    
    var stackViewH: UIStackView = UIStackView()
    var stackViewV: UIStackView = UIStackView()
    
    var nameEntryArray: [UITextField] = []
    var setsEntryArray: [UITextField] = []
    var repsEntryArray: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        stackViewV = UIStackView(frame: CGRect(x: 20, y: 100, width: 374, height: 40))
        stackViewV.addArrangedSubview(stackViewH)
        stackViewV.axis = .vertical
        stackViewV.distribution = .fillEqually
        stackViewV.alignment = .fill
        stackViewV.spacing = 10

        /*stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: workoutName.bottomAnchor, constant: 8).isActive = true*/
        stackViewV.addArrangedSubview(createRow())
        stackViewV.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(stackViewV)
        
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        stackViewV.addArrangedSubview(createRow())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createRow() -> UIStackView{
        let nameEntry = UITextField()
        nameEntry.placeholder = "Name"
        nameEntry.delegate = self
        nameEntry.backgroundColor = .white
        
        nameEntryArray.append(nameEntry)
        
        //view.addSubview(nameEntry)
        
        let setsEntry = UITextField()
        setsEntry.placeholder = "Sets"
        setsEntry.delegate = self
        setsEntry.backgroundColor = .white
        
        setsEntryArray.append(nameEntry)
        //view.addSubview(setsEntry)
        
        let repsEntry = UITextField()
        repsEntry.placeholder = "Reps"
        repsEntry.delegate = self
        repsEntry.backgroundColor = .white
        
        repsEntryArray.append(nameEntry)
        //view.addSubview(repsEntry)
        
        
        stackViewH = UIStackView(frame: CGRect(x: 20, y: 100, width: 374, height: 40))
        stackViewH.addArrangedSubview(nameEntry)
        stackViewH.addArrangedSubview(repsEntry)
        stackViewH.addArrangedSubview(setsEntry)
        stackViewH.axis = .horizontal
        stackViewH.distribution = .fillEqually
        stackViewH.alignment = .fill
        stackViewH.spacing = 10
        
        stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        return stackViewH
    }
    
}
