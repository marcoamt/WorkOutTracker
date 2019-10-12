//
//  Constants.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    struct Storyboard {
        static let workoutViewController = "workoutVC"
        static let welcomeViewController = "welcomeVC"
        static var userID = ""
        static var wo : [Workout] = DataWorkouts.loadData()
        
    }
}
