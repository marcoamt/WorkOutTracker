//
//  WelcomeViewController.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 06/10/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class WelcomeViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var woButton: UIButton!
    @IBOutlet weak var mapsButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    
    
    @IBOutlet weak var nav: UINavigationItem!
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("nib name!!!! = " + nibName!)
        nav.hidesBackButton = true
        nav.rightBarButtonItem = UIBarButtonItem(title: "Log-out", style: .plain, target: self, action: #selector(logOutTapped))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        topView.layer.insertSublayer(gradientLayer, at: 0)
        
        woButton.alignImageAndTitleVertically()
        mapsButton.alignImageAndTitleVertically()
        historyButton.alignImageAndTitleVertically()
        Utilities.styleHomeButton(woButton)
        Utilities.styleHomeButton(mapsButton)
        Utilities.styleHomeButton(historyButton)
        
        let user = Auth.auth().currentUser
        
        
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: user!.uid).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let name = data["name"] as? String
                        self.userLabel.text = "Welcome " + name!
                        //print("\(document.documentID) => \(document.data())")
                    }
                }
        }
        /*if let user = user {
          // The user's ID, unique to the Firebase project.
          // Do NOT use this value to authenticate with your backend server,
          // if you have one. Use getTokenWithCompletion:completion: instead.
          //let uid = user.uid
          //let email = user.email
            //userLabel.text = email
          // ...
        }*/
    }
    
    @IBAction func woButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "workoutsSegue", sender: nil)
    }
    @IBAction func mapsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "mapSegue", sender: nil)
    }
    @IBAction func historyButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "historySegue", sender: nil)
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        try! Auth.auth().signOut()

        performSegue(withIdentifier: "logoutSegue", sender: nil)
   }
}
extension UIButton {
  func alignImageAndTitleVertically(padding: CGFloat = 4.0) {
        let imageSize = imageView!.frame.size
        let titleSize = titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding

        imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
}


