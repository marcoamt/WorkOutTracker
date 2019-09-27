//
//  HomeViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit

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

}
