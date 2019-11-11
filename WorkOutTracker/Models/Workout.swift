//
//  Workout.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 20/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import Foundation

struct Workout: Codable{
    var id: String = ""
    var name: String
    var descrizione: String
    var exercise: [Exercise]
    
    init(id: String, name: String, descrizione: String, exercise: [Exercise]) {
        self.id = id
        self.name = name
        self.descrizione = descrizione
        self.exercise = exercise
    }
    
    init(name: String, descrizione: String, exercise: [Exercise]) {
        self.name = name
        self.descrizione = descrizione
        self.exercise = exercise
    }
}
