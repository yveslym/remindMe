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

    var mainStackView = CustomStack()
    var buttonsStackView = CustomStack()
    var facebookLoginButton = CustomButton()
    var googleLoginButton =  CustomButton()
    var appTittleLabel = CustomLabel()
    var separatorLabel = CustomLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpBackground()
        setUpGoogleButton()
        setUpFacebookButton()
        setUpAppTittleLabel()
        setUpSeparatorLabel()
        setUpBUttonsStackView()
        mainStackViewAutoLayout()
        //self.view.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    }

    func setUpBackground (){

        let image = UIImage.init(named: "don-t-forget")
        let backgroundImage = UIImageView.init(image: image)
        backgroundImage.frame = view.frame
        self.view.addSubview(backgroundImage)
        backgroundImage.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    fileprivate func setUpAppTittleLabel(){
        
        appTittleLabel = CustomLabel(fontSize: 40, text: "Remindme", textColor: .white)
        appTittleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 40)
        appTittleLabel.textAlignment = .center
    }
    
    /// Yves -- Put your Facebook SDK Logic here!!!
    @objc fileprivate func facebookSignInButtonTapped(_ sender: UIButton){
        print("Facebook sign in butotn tapped")
        let facebookLoginManager = FBSDKLoginManager()
        facebookLoginManager.logIn(withReadPermissions: ["email","public_profile"], from: self) { (result, error) in

            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {

                    guard (FBSDKAccessToken.current()) != nil else {return}
                    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)

                    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                        if error != nil {
                            // ...
                            self.presentAlert(title: "Login Error", message: " Couldn't login, With Facebook at this moment")
                            return
                        }

                    // User is signed in
                    UserServices.loginWithFacebook(sender: self, completion: { (user) in
                        if let user = user{

                            let destinationVC = GroupListViewController()
                            self.navigationController?.pushViewController(destinationVC, animated: true)
                            User.setCurrentUser(user: user, writeToUserDefaults: true)
                            // Add a little animation or loading after signin with FBK if u can
                        }
                        else{
                            self.presentAlert(title: "Login Error", message: " Couldn't login, try again in a few")
                            return
                        }
                    })
                }
            }
        }
    }
}

    
    // Signs in the user with their Google credentials
    @objc fileprivate func GooglesigniButtonTapped(_ sender: UIButton){
        print("Google sign in butotn tapped")
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    // Toggles the signup view controller
    fileprivate func  setUpSeparatorLabel(){
        
        separatorLabel = CustomLabel(fontSize: 20, text: "OR", textColor: .white)
        separatorLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        separatorLabel.textAlignment = .center
    }
    
    fileprivate func setUpGoogleButton(){
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self as GIDSignInDelegate
        GIDSignIn.sharedInstance().uiDelegate = self as GIDSignInUIDelegate
        
        googleLoginButton = CustomButton(title: "Login with Google",
                                         fontSize: 20,
                                         titleColor: .gray,
                                         target: self,
                                         action: #selector(GooglesigniButtonTapped(_:)),
                                         event: .touchUpInside)
        
        googleLoginButton.setImage(UIImage(named: "google"), for: .normal)
        googleLoginButton.imageView?.widthAnchor.constraint(equalTo: googleLoginButton.widthAnchor, multiplier: 0.5)
        googleLoginButton.imageView?.heightAnchor.constraint(equalTo: googleLoginButton.heightAnchor)
        googleLoginButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7)
        googleLoginButton.semanticContentAttribute = .forceLeftToRight
        googleLoginButton.titleLabel?.textAlignment = .center
        googleLoginButton.layer.cornerRadius = 10
        googleLoginButton.clipsToBounds = true
        googleLoginButton.layer.masksToBounds = false
        googleLoginButton.layer.shadowRadius = 1
        googleLoginButton.backgroundColor = .white
        googleLoginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
    
    fileprivate func setUpFacebookButton(){
        
        facebookLoginButton = CustomButton(title: "Login with Facebook",
                                           fontSize: 20,
                                           titleColor: .white,
                                           target: self,
                                           action: #selector(facebookSignInButtonTapped(_:)),
                                           event: .touchUpInside)
        
        facebookLoginButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookLoginButton.imageView?.widthAnchor.constraint(equalTo: facebookLoginButton.widthAnchor, multiplier: 0.5)
        facebookLoginButton.imageView?.heightAnchor.constraint(equalTo: facebookLoginButton.heightAnchor)
        facebookLoginButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7)
        facebookLoginButton.semanticContentAttribute = .forceLeftToRight
        facebookLoginButton.titleLabel?.textAlignment = .center
        facebookLoginButton.layer.cornerRadius = 10
        facebookLoginButton.clipsToBounds = true
        facebookLoginButton.layer.masksToBounds = false
        facebookLoginButton.layer.shadowRadius = 1
        facebookLoginButton.backgroundColor = .facebookBlue
        facebookLoginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20)
    }
    
    fileprivate func setUpBUttonsStackView(){
        
        buttonsStackView = CustomStack(subview: [facebookLoginButton, separatorLabel, googleLoginButton],
                                       alignment: .center,
                                       axis: .vertical,
                                       distribution: .fill)
        
        NSLayoutConstraint.activate([facebookLoginButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.4),
                                     facebookLoginButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8),
                                     googleLoginButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.4),
                                     googleLoginButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8),
                                     //separatorLabel.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.1),
                                     separatorLabel.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8)])
    }
    
    
    fileprivate func mainStackViewAutoLayout(){
        
        mainStackView = CustomStack(subview: [appTittleLabel, buttonsStackView],
                                    alignment: .center,
                                    axis: .vertical,
                                    distribution: .fill)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
                                     mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
                                     mainStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.95),
                                     mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTittleLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     buttonsStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2),
                                     buttonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
                                     buttonsStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
                                     ])
    }
}
