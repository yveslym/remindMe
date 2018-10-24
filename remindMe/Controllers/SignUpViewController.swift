//
//  SignUpViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 10/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController{
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    /// Method to be called when the use taps the register button
    @IBAction func registerButtonTaped(_ sender: UIButton) {
        
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let reEnterPassword = reEnterPasswordTextField.text else {
            
            Constant.setUpAlert(alertTitle: "Field Missing",
                                alertMessage: "Please fill out all fields",
                                alertStyle: .alert,
                                actionTitle: "Return",
                                actionStyle: .cancel)
            return
        }
        
        // Checking if the user enters short inputs that does not meet the requirements
        if email.count < 3 || password.count < 3 || name.count < 3 {
            
            Constant.setUpAlert(alertTitle: "Imcoplete fields",
                                alertMessage: "Fields are either too short or empty",
                                alertStyle: .alert,
                                actionTitle: "Return",
                                actionStyle: .cancel)
            return
        }
        
        // checking the the user's original and re-entered passwords don't match
        if (password != reEnterPassword){
            
            Constant.setUpAlert(alertTitle: "Unmatched Passwords",
                                alertMessage: "Your passwords don't match, try again.",
                                alertStyle: .alert,
                                actionTitle: "Return",
                                actionStyle: .cancel)
        }
        
        // if everything is well...proceed creating the user account
        UserServices.signUp(email, password) { (newUser) in
           User.setCurrentUser(user: newUser as! User, writeToUserDefaults: true)
           self.performSegue(withIdentifier: Constant.backToGroupListSegueIdentifier, sender: nil)
        }
    }
}
