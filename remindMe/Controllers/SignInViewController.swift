//
//  SignInViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 10/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFiedl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self as UITextFieldDelegate
        passwordTextFiedl.delegate = self as UITextFieldDelegate
    }
    
    
    /// function triggered when the user taps the login button
    @IBAction func loginButtonIsTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextFiedl.text else {return}
        if (email.count) > 4 && (password.count) > 4 {
            
            UserServices.signIn(email, password) { (user) in
                
                if let user = user as? User{
                    // setting the logged in user as the current app user
                    User.setCurrentUser(user: user, writeToUserDefaults: true)
                    self.performSegue(withIdentifier: Constant.backToGroupListSegueIdentifier, sender: nil)
                }else {
                    
                    Constant.setUpAlert(alertTitle: "Authentification Error",
                                        alertMessage: "Check your username or password",
                                        alertStyle: .alert,
                                        actionTitle: "Return",
                                        actionStyle: .cancel)
                }
            }
        }
        
    }
    
    
    // THIS METHOD IS USED FOR UNWINDING SEGUE
    @IBAction func unwindtoLoginPage(_ segue: UIStoryboardSegue){
        // leave empty for now
    }
    
}

extension SignInViewController: UITextFieldDelegate{
    
    // FUNCTION TO SELECT THE NEXT TEXTFIELD TO PROMPT FOR INPUT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case emailTextField:
            
            passwordTextFiedl.becomeFirstResponder()
            
        case passwordTextFiedl:
            
           passwordTextFiedl.resignFirstResponder()
            
        default:
            
            passwordTextFiedl.resignFirstResponder()
        }
        
        return true
    }
}
