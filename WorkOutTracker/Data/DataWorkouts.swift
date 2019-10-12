//
//  DataWorkouts.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class DataWorkouts{

    static func loadData() -> [Workout]{
        var array: [Workout] = []
        //prendi i dati dal db
        let user = Auth.auth().currentUser
        print(user!.uid)
        let db = Firestore.firestore()
        db.collection("workouts").whereField("uid", isEqualTo: user!.uid).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var i: Int = 0
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let a = data["Exercises"] as! Dictionary<String, Any>
                        let reps = a["reps"] as! String
                        let sets = a["sets"] as! String
                        let ex: Exercise = Exercise(name: a["nome"] as! String, reps: Int(reps)!, sets: Int(sets)!)
                        let w = Workout(name: data["nome"] as! String, descrizione: data["descrizione"] as! String, exercise: [ex])
                        array.append(w)
                        i += 1
                        //print("\(document.documentID) => \(document.data())")
                        print("Constants " + String(reps))
                    }
                }
        }
        return array
    }
}
