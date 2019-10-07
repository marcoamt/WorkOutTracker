//
//  LoginViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth

@available(iOS 13.0, *)
class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(loginButton)
    }
      
    func showError(_ error: String){

      errorLabel.text = error
      errorLabel.alpha = 1
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {

        let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.showError("Wrong Email or password")
            }else{
                //saving user id on app
                Constants.Storyboard.userID = result!.user.uid
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
      
        
}
