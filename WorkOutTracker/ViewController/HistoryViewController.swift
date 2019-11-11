//
//  HistoryViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 05/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {
    
    var names:[String] = []
    
    var stackViewH: UIStackView = UIStackView()
    var stackViewV: UIStackView = UIStackView()
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        //v.backgroundColor = .cyan
        v.setContentOffset(CGPoint(x: 0, y: 200), animated: true)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        nameLabel.text = "Workout Name"
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let dateLabel = UILabel()
        dateLabel.text = "Date"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewH = UIStackView()
        stackViewH.addArrangedSubview(nameLabel)
        stackViewH.addArrangedSubview(dateLabel)
        stackViewH.axis = .horizontal
        stackViewH.distribution = .fillEqually
        stackViewH.alignment = .center
        stackViewH.spacing = 10
        stackViewV.addArrangedSubview(stackViewH)
        
        
        getData()

    }
    
    func getData(){
        
        //prendi i dati dal db
        let user = Auth.auth().currentUser

        let db = Firestore.firestore()
        db.collection("workoutsDone").whereField("idUser", isEqualTo: user!.uid).getDocuments() { (querySnapshot, err) in if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var namesArray:[String] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        print(data)
                        let idW = data["idWorkout"] as! String
                        let date = document["date"] as! Timestamp
                        let d = date.dateValue()
                        
                        let doc = db.collection("workouts").document(idW)
                        
                        doc.getDocument { (document, error) in
                            if let document = document, document.exists {
                                let name = document["nome"] as! String
                                namesArray.append(name)
                                let newRow = self.createRow(name: name, d: d)
                                self.stackViewV.addArrangedSubview(newRow)

                                //print("Document data: \(dataDescription)")
                            } else {
                                print("Document does not exist")
                            }
                        }
                    }
                }
            }
    }
    
    
    
    func createRow(name: String, d: Date) -> UIStackView{
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let calanderDate = Calendar.current.dateComponents([.day, .year, .month, .hour, .minute], from: d)
        let dateLabel = UILabel()
        dateLabel.text = String(calanderDate.day!) + "/" + String(calanderDate.month!) + "/" + String(calanderDate.year!) +  " " + String(calanderDate.hour!) + ":" + String(calanderDate.minute!)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        stackViewH = UIStackView()
        stackViewH.addArrangedSubview(nameLabel)
        stackViewH.addArrangedSubview(dateLabel)
        stackViewH.axis = .horizontal
        stackViewH.distribution = .fillEqually
        stackViewH.alignment = .center
        stackViewH.spacing = 10

        
        //stackViewV.translatesAutoresizingMaskIntoConstraints = false
        
        return stackViewH
    }
    

}
