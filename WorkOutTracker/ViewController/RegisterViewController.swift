//
//  RegisterViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

@available(iOS 13.0, *)
class RegisterViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupElements()
        
    }

    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(nameField)
        Utilities.styleTextField(surnameField)
        Utilities.styleTextField(emailField)
        Utilities.styleTextField(passwordField)
        Utilities.styleFilledButton(registerButton)
    }
    
    func validateFields() -> String? {
        //check if some fields are empty
        if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
           surnameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "fill all fields"
        }
        
        //check if the password is secure
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(password) == false{
            return "Password is not secure"
            
        }
        return nil
    }

    @available(iOS 13.0, *)
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        let error = validateFields()
        if error != nil{
            showError(error!)
        }else{
            //clean data
            let name = nameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let surname = surnameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("error creating user")
                }
                else{
                    //no errors, so store user information
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name": name, "surname": surname, "uid": result!.user.uid]) { (error) in
                        if error != nil{
                            self.showError("can't store data")
                        }
                    }
                    
                    //go to workoutsview saving user ID on app
                    Constants.Storyboard.userID = result!.user.uid
                    self.performSegue(withIdentifier: "registerDoneSegue", sender: nil)
                    //self.goToWOVC()
                }
            }
        }
        
    }

    func showError(_ error: String){

        errorLabel.text = error
        errorLabel.alpha = 1
    }
    
    func goToWOVC(){
        let woVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.workoutViewController) as? WorkoutsViewController
        view.window?.rootViewController = woVC
        view.window?.makeKeyAndVisible()
    }
}
