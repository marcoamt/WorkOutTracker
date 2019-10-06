//
//  HomeViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    

    func setupElements(){
        Utilities.styleFilledButton(loginButton)
        Utilities.styleFilledButton(registerButton)
    }
    
    override func viewWillAppear(_ animated: Bool){
         super.viewWillAppear(false)
         if Auth.auth().currentUser != nil {
           self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }

}
