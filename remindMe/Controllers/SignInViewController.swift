//
//  SignInViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 10/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController{
// This View Controller class handles functionality sign in a user from the client side
    
    // google and facebbok button provided by the sdk
     //var googleButton: GIDSignInButton!
     var facebookButton: FBSDKLoginButton!
    
    
    var mainStackView = UIStackView()
    var textInputStackView = UIStackView()
    var selectableButtonsStackView = UIStackView()
    var signInButtonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGoogleButton()
       
        emailAddressTextField.delegate = self as UITextFieldDelegate
        passwordTextField.delegate = self as UITextFieldDelegate
        self.view.backgroundColor = .gloomyBlue
        setUpMainStackView()
        setUpSelectableButtonsStackView()
        setUpSignInButtonsStackView()
        setUpTextInputStackView()
        
    }
    

    // THIS METHOD IS USED FOR UNWINDING SEGUE
    @IBAction func unwindtoLoginPage(_ segue: UIStoryboardSegue){
        // leave empty for now
    }
    
    
    /// Signs in the user with their credentials
    @objc fileprivate func signInButtonTapped(_ sender: UIButton){
        
        guard let email = emailAddressTextField.text, let password = passwordTextField.text else {return}
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
    
    /// Yves -- Put your Facebook SDK Logic here!!!
    @objc fileprivate func facebookSignInButtonTapped(_ sender: UIButton){
        print("Facebook sign in butotn tapped")
    }
    
    // Signs in the user with their Google credentials
    @objc fileprivate func GooglesigniButtonTapped(_ sender: UIButton){
        print("Google sign in butotn tapped")
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    // Toggles the signin view controller
    @objc fileprivate func selectableSignInButtonTapped(_ sender: UIButton){
        print("selectable Sign in button clicked")
    }
    
    // Toggles the signup view controller
    @objc fileprivate func selectableSignUpButtonTapped(_ sender: UIButton){
        
        print("selectable sign up button clicked")
    }
    
     // - MARK: UI ELEMENTS AND METHODS
    
    
    // Creates and sets up a label to display the app's name
    fileprivate let appTittleLabel: UILabel = {

        let label = UILabel()
        label.text = "GeoMinder"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // Creates and sets up a textfield for the email address
    fileprivate let emailAddressTextField: UITextField = {
        let textField = UITextField()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.layer.shadowRadius = 1
        textField.leftViewMode = .always
        textField.leftView = imageView
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "textfield_avatar")
        
        return textField
    }()
    
    
    // Creates and sets up a textfield for the password
    fileprivate let passwordTextField: UITextField = {
       
        let textField = UITextField()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.leftViewMode = .always
        textField.leftView = imageView
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.layer.masksToBounds = true
        textField.layer.shadowRadius = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "textfield_avatar")
        
        return textField
    }()
    
    
    // Creates and sets up a button to select the signup view controller
    fileprivate let selectableSignInButton: UIButton = {
       
        let button = UIButton()
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(selectableSignInButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // Creates and sets up a button to select the signin view controller
    fileprivate let selectableSignUpButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize:18)
        button.addTarget(self, action: #selector(selectableSignUpButtonTapped(_:)), for: .touchUpInside)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // Creates and sets up a button to sign in
    fileprivate let signInButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.shadowRadius = 1
        button.setTitleColor(.gloomyBlue, for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // creates and sets a button for the facebook sdk sign in
    fileprivate let facebookSignInButton: UIButton = {
      
        let button = UIButton()

        button.backgroundColor = .white
        button.setTitle("Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "facebook"), for: .normal)
        button.imageView?.anchor(top: button.topAnchor, left: button.leftAnchor, bottom: button.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 0, width: 25, height: 0, enableInsets: false)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7)
        button.semanticContentAttribute = .forceLeftToRight
        button.titleLabel?.textAlignment = .center
        
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.shadowRadius = 1
        button.setTitleColor(.gloomyBlue, for: .normal)
        button.addTarget(self, action: #selector(facebookSignInButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // creates and sets a button for the facebook sdk sign in
    fileprivate let googleSignInButton: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .white
        button.setTitle("Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "google"), for: .normal)
        button.imageView?.anchor(top: button.topAnchor, left: button.leftAnchor, bottom: button.bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 5, paddingBottom: 10, paddingRight: 0, width: 25, height: 0, enableInsets: false)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7)
        button.semanticContentAttribute = .forceLeftToRight
        button.titleLabel?.textAlignment = .center
        
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.layer.shadowRadius = 1
        button.setTitleColor(.gloomyBlue, for: .normal)
        button.addTarget(self, action: #selector(GooglesigniButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    // - MARK: FUNTIONS
    
    
    // Funtion to layout and constraint the outer most stack view that'll contain all the views and elements in the VC
    fileprivate func setUpMainStackView(){
        
        mainStackView = UIStackView(arrangedSubviews: [appTittleLabel,
                                                       selectableButtonsStackView,
                                                       textInputStackView,
                                                       signInButtonsStackView])
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
        
        textInputStackView = UIStackView(arrangedSubviews: [emailAddressTextField, passwordTextField, signInButton])
        textInputStackView.alignment = .center
        textInputStackView.axis = .vertical
        textInputStackView.distribution = .fillEqually
        textInputStackView.backgroundColor = .black
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(textInputStackView)
        
        textInputStackView.anchor(top: selectableButtonsStackView.bottomAnchor, left: mainStackView.leftAnchor, bottom: signInButtonsStackView.topAnchor, right: mainStackView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        
        emailAddressTextField.anchor(top: textInputStackView.topAnchor, left: textInputStackView.leftAnchor, bottom: passwordTextField.topAnchor, right: textInputStackView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        passwordTextField.anchor(top: emailAddressTextField.bottomAnchor, left: textInputStackView.leftAnchor, bottom: signInButton.topAnchor, right: textInputStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        signInButton.anchor(top: passwordTextField.bottomAnchor, left: textInputStackView.leftAnchor, bottom: textInputStackView.bottomAnchor, right: textInputStackView.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0, enableInsets: false)
    }
    
    /// Funtion set up and constraint the two seletable signin and signup buttons
    fileprivate func setUpSelectableButtonsStackView(){
        
        selectableButtonsStackView = UIStackView(arrangedSubviews: [selectableSignInButton, selectableSignUpButton])
        selectableButtonsStackView.alignment = .center
        selectableButtonsStackView.axis = .horizontal
        selectableButtonsStackView.distribution = .fillEqually
        selectableButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(selectableButtonsStackView)
        
//        selectableButtonsStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.15).isActive = true
//         selectableButtonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 1).isActive = true
        
        NSLayoutConstraint.activate([selectableButtonsStackView.topAnchor.constraint(equalTo: appTittleLabel.bottomAnchor, constant: 10),
                                     selectableButtonsStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
                                     selectableButtonsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 20),
                                     selectableButtonsStackView.bottomAnchor.constraint(equalTo: textInputStackView.topAnchor, constant: 20)])
    }
    
    /// Funtion to layout and constraint the signin button
    fileprivate func setUpSignInButtonsStackView(){
        
        signInButtonsStackView = UIStackView(arrangedSubviews: [facebookSignInButton, googleSignInButton])
        
        signInButtonsStackView.alignment = .center
        signInButtonsStackView.distribution = .fillEqually
        signInButtonsStackView.axis = .horizontal
        signInButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(signInButtonsStackView)
        
        signInButtonsStackView.anchor(top: textInputStackView.bottomAnchor, left: mainStackView.leftAnchor, bottom: mainStackView.bottomAnchor, right: mainStackView.rightAnchor, paddingTop: 0, paddingLeft: 50, paddingBottom: 0, paddingRight: 50, width: 0, height: 0, enableInsets: false)
        
        facebookSignInButton.anchor(top: signInButtonsStackView.topAnchor, left: signInButtonsStackView.leftAnchor, bottom: signInButtonsStackView.bottomAnchor, right: googleSignInButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 135, paddingRight: 10, width: 0, height: 0, enableInsets: false)

        googleSignInButton.anchor(top: signInButtonsStackView.topAnchor, left: facebookSignInButton.rightAnchor, bottom: signInButtonsStackView.bottomAnchor, right: signInButtonsStackView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 135, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
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

/// authenticate with google
extension SignInViewController:  GIDSignInDelegate, GIDSignInUIDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                self.presentAlert(title: "Login Error", message: "coun't register please try again!!!")
                return
            }
            // User is signed in
            // register user
            UserServices.loginWithGoogle(googleUser: user, completion: { (user) in
                if let user = user{
                   // self.performSegue(withIdentifier: Constant.backToGroupListSegueIdentifier, sender: nil)
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    guard let mainPageVC = storyBoard.instantiateViewController(withIdentifier: "GroupListViewController") as? GroupListViewController else { return }
                    
                    let navigation = UINavigationController(rootViewController: mainPageVC)
                    
                    User.setCurrentUser(user: user, writeToUserDefaults: true)
                    self.present(navigation, animated: true)
                }
                else{
                    self.presentAlert(title: "Login Error", message: "coun't register please try again!!!")
                }
            })
        }
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        print("present google UI")
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
         print("dismiss google UI")
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }

    
    func setUpGoogleButton(){
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
       
        
//         self.googleButton = GIDSignInButton()
//        self.googleButton.colorScheme = .dark
//        self.googleButton.style = .wide
//        self.googleButton.layer.masksToBounds = true
//         self.googleButton.layer.cornerRadius = 15
//        //self.googleButton.style =
        
     GIDSignIn.sharedInstance().delegate = self
     GIDSignIn.sharedInstance().uiDelegate = self
    }
}
