//
//  Constants.swift
//  WorkOutTracker
//
//  Created by Marco Mendoza on 26/09/2019.
//  Copyright © 2019 Marco Mendoza. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleAddTextField(_ textfield:UITextField) {
        
        
        //textfield.layer.cornerRadius = 10
        
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = .white
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func styleCellView(_ view:UIView) {
        
        // Filled rounded corner style
        view.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        view.layer.cornerRadius = 15.0
    }
    
    static func styleHomeButton(_ button:UIButton){
        button.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
}
