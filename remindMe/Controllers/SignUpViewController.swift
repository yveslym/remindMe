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
            
            let emptyFieldAlert = UIAlertController(title: "Field Missing",
                                          message: "Please fill out all form",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Return",
                                       style: .cancel,
                                       handler: nil)
            emptyFieldAlert.addAction(action)
            self.present(emptyFieldAlert, animated: true, completion: nil)
            return
        }
        
        // check if
        if email.count < 3 || password.count < 3 || name.count < 3 {
            let shortInputsAlert = UIAlertController(title: "Imcoplete fields",
                                                     message: "some field are either too short or empty",
                                                     preferredStyle: .alert)
            let action = UIAlertAction(title: "Return",
                                       style: .cancel,
                                       handler: nil)
            shortInputsAlert.addAction(action)
            self.present(shortInputsAlert, animated: true, completion: nil)
            return
        }
        
        UserServices.signUp(email, password) { (newUser) in
           User.setCurrentUser(user: newUser as! User, writeToUserDefaults: true)
        }
        
    }
}
