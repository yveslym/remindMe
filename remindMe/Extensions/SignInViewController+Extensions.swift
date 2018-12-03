//
//  SignInViewController+Extensions.swift
//  remindMe
//
//  Created by Medi Assumani on 12/2/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase

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
    
}

