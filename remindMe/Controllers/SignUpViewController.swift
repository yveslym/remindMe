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
    
    private func signUpUser(){
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let reEnterPassword = reEnterPasswordTextField.text else {return}
        
        UserServices.signUp(email, password) { (user) in
            // some code goes here
            print("User succesfully signed up")
        }
    }
    
    
    
    /// Method to be called when the use taps the register button
    @IBAction func registerButtonTaped(_ sender: UIButton) {
    }
}
