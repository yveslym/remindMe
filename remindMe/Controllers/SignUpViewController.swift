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
            
            let alert = UIAlertController(title: "Field Missing",
                                          message: "Please fill out all form",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Return",
                                       style: .cancel,
                                       handler: nil)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // check if
            // email size is less than three or password size is less than three or name size is less than 3
                // if it is
                    // send an alert
                // if not
                    // sign up the user
                    // set the current user to the signed up user
        
    }
}
