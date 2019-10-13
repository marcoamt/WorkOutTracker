//
//  Workout.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 20/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import Foundation

struct Workout: Codable{
    var name: String
    var descrizione: String
    var exercise: [Exercise]
}
