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
// This View Controller class handles functionality sign in a user from the client side
    

    var mainStackView = UIStackView()
    var textInputStackView = UIStackView()
    var selectableButtonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailAddressTextField.delegate = self as UITextFieldDelegate
        passwordTextField.delegate = self as UITextFieldDelegate
        self.view.backgroundColor = .gloomyBlue
        setUpMainStackView()
        setUpTextInputStackView()
        setUpSelectableButtons()
        setUpSignInButton()
        
    }
    

    
    /// function triggered when the user taps the login button
//    @IBAction func loginButtonIsTapped(_ sender: Any) {
//
//        guard let email = emailTextField.text, let password = passwordTextFiedl.text else {return}
//        if (email.count) > 4 && (password.count) > 4 {
//
//            UserServices.signIn(email, password) { (user) in
//
//                if let user = user as? User{
//                    // setting the logged in user as the current app user
//                    User.setCurrentUser(user: user, writeToUserDefaults: true)
//                    self.performSegue(withIdentifier: Constant.backToGroupListSegueIdentifier, sender: nil)
//                }else {
//
//                    Constant.setUpAlert(alertTitle: "Authentification Error",
//                                        alertMessage: "Check your username or password",
//                                        alertStyle: .alert,
//                                        actionTitle: "Return",
//                                        actionStyle: .cancel)
//                }
//            }
//        }
//
//    }
//
//
    // THIS METHOD IS USED FOR UNWINDING SEGUE
    @IBAction func unwindtoLoginPage(_ segue: UIStoryboardSegue){
        // leave empty for now
    }
    
    
    
            // THIS PART OF THE FILE CONTAINS THE USER INTERFACE FUNCTIONALITIES
    
     // - MARK: PROPERTIES AND UI ELEMENTS
    
    
    // Creates and sets up a label to display the app's name
    fileprivate let appTittleLabel: UILabel = {

        let label = UILabel()
        label.text = "GeoMinder"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    
    // Creates and sets up a textfield for the email
    fileprivate let emailAddressTextField: UITextField = {
        // DRY CODE MEDI!!!!
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.layer.shadowRadius = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    // Creates and sets up a textfield for the password
    fileprivate let passwordTextField: UITextField = {
       
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.layer.shadowRadius = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    // Creates and sets up a button to select the signup view controller
    fileprivate let selectableSignInButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // Creates and sets up a button to select the signin view controller
    fileprivate let selectableSignUpButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // Creates and sets up a button to sign in
    fileprivate let signInButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("SIGN IN", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.shadowRadius = 1
        button.setTitleColor(.gloomyBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    
    
    // - MARK: FUNTIONS
    
    
    /// Funtion to layout and constraint the app's tittle
    fileprivate func setUpAppTittle(){
        
        
    }
    
    /// Funtion to layout and constraint the signin button
    fileprivate func setUpSignInButton(){
        
        NSLayoutConstraint.activate([signInButton.topAnchor.constraint(equalTo: textInputStackView.bottomAnchor, constant: 20),
                                     signInButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -50),
                                     signInButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 50),
                                     signInButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -50)])
    }
    
    // Funtion to layout and constraint the outer most stack view that'll contain all the views and elements in the VC
    fileprivate func setUpMainStackView(){
        
        mainStackView = UIStackView(arrangedSubviews: [appTittleLabel,
                                                       selectableButtonsStackView,
                                                       textInputStackView,
                                                       signInButton])
        mainStackView.alignment = .center
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    // Funtion to layout and constraint the two textfields
    fileprivate func setUpTextInputStackView(){
        
        textInputStackView = UIStackView(arrangedSubviews: [emailAddressTextField, passwordTextField])
        textInputStackView.alignment = .center
        textInputStackView.axis = .vertical
        textInputStackView.distribution = .fillEqually
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(textInputStackView)
        
        NSLayoutConstraint.activate([textInputStackView.topAnchor.constraint(equalTo: selectableButtonsStackView.topAnchor, constant: 10),
                                     textInputStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
                                     textInputStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 20),
                                     textInputStackView.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: 20)])
        
    }
    
    /// Funtion set up and constraint the two seletable signin and signup buttons
    fileprivate func setUpSelectableButtons(){
        
        selectableButtonsStackView = UIStackView(arrangedSubviews: [selectableSignInButton, selectableSignUpButton])
        selectableButtonsStackView.alignment = .center
        selectableButtonsStackView.axis = .horizontal
        selectableButtonsStackView.distribution = .fillEqually
        selectableButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(selectableButtonsStackView)
        
        NSLayoutConstraint.activate([selectableButtonsStackView.topAnchor.constraint(equalTo: appTittleLabel.bottomAnchor, constant: 10),
                                     selectableButtonsStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
                                     selectableButtonsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 20),
                                     selectableButtonsStackView.bottomAnchor.constraint(equalTo: textInputStackView.topAnchor, constant: 20)])
    }
    
}







extension SignInViewController: UITextFieldDelegate{

    // FUNCTION TO SELECT THE NEXT TEXTFIELD TO PROMPT FOR INPUT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        switch textField {

        case emailAddressTextField:

            passwordTextField.becomeFirstResponder()

        case passwordTextField:

           passwordTextField.resignFirstResponder()

        default:

            passwordTextField.resignFirstResponder()
        }

        return true
    }
}
