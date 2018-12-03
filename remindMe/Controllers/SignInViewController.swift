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
        
        setUpGoogleButton()
        setUpFacebookButton()
        setUpAppTittleLabel()
        setUpSeparatorLabel()
        setUpBUttonsStackView()
        mainStackViewAutoLayout()
        self.view.backgroundColor = .black
    }
    
    fileprivate func setUpAppTittleLabel(){
        
        appTittleLabel = CustomLabel(fontSize: 40, text: "Remindme", textColor: .white)
        appTittleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 40)
        appTittleLabel.textAlignment = .center
    }
    
    fileprivate func setUpSeparatorLabel(){
        
        separatorLabel = CustomLabel(fontSize: 20, text: "OR", textColor: .black)
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
                                       distribution: .fillEqually)
        
        NSLayoutConstraint.activate([facebookLoginButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.4),
                                     facebookLoginButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8),
                                     googleLoginButton.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.4),
                                     googleLoginButton.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8),
                                     separatorLabel.heightAnchor.constraint(equalTo: buttonsStackView.heightAnchor, multiplier: 0.2),
                                     separatorLabel.widthAnchor.constraint(equalTo: buttonsStackView.widthAnchor, multiplier: 0.8)])
    }
    
    
    fileprivate func mainStackViewAutoLayout(){
        
        mainStackView = CustomStack(subview: [appTittleLabel, buttonsStackView],
                                    alignment: .center,
                                    axis: .vertical,
                                    distribution: .fill)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                                     mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                                     mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
                                     mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
                                     mainStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
                                     mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     appTittleLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     buttonsStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.4),
                                     buttonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
                                     buttonsStackView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
                                     ])
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
}
