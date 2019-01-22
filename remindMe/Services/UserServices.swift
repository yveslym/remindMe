//
//  UserServices.swift
//  Linner
//
//  Created by Yves Songolo on 8/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

struct UserServices{
    /* Implements The CRUD Services of a User model
     
     Methods :
     - show : shows a single user
     - create : creates a single user
     - signUp: registers a single user
     - signIn: logs in a single user
     - update : updates a single user
     */
    
    
    /* THIS METHOD CREATES A SINGLE USER OBJECT AND STORES IT IN THE DATABASE
      @param user : The user object to be created
      @param completion -> Any: The single user obejct to be returned after the method call
    */
   private static func create(user: User, completion: @escaping(Any)->()){
        
        let authUser = Auth.auth().currentUser
       
        let ref = Constant.user((authUser?.uid)!)
        ref.setValue(user.toDictionary()) { (error, _) in
            if error != nil{
                return completion(error!)
            }
            return completion(user)
        }
}
    
    
    /* THIS METHOD RETRIEVE USER FROM THE DATABASE
      @param completion -> User: The single user obejct to be returned after the method call
    */
    static func show(completion: @escaping(User?)-> ()){
        let uid = Auth.auth().currentUser?.uid
        let ref = Constant.user(uid!)
        ref.observeSingleEvent(of: .value) { (snapshot) in
        
            if snapshot.exists(){
                let user = try! JSONDecoder().decode(User.self, withJSONObject: snapshot.value!)
                return completion(user)
            }
            else{
                return completion(nil)
            }
        }
    }

    
    /* THIS METHOD SIGNS UP A NEW USER
     @param email : The user's email address
     @param password: The user's password
     @param completion -> Any: The single user obejct to be returned after the method call
    */
    static func signUp(_ email: String, _ password: String, completion: @escaping (Any)->()){
        Auth.auth().createUser(withEmail: email, password: password) { (authUser, error) in
            guard authUser != nil else {return completion(error!)}
           
            let user = User.init("", (authUser?.user.uid)!, (authUser?.user.email!)!)
            create(user: user, completion: { (newUser) in
                if (newUser as? User) != nil{
                    show(completion: { (user) in
                        print("User succesfully signed up")
                        return completion(user!)
                    })
                }
            })
        }
     }
    
    
    /* THIS METHOD LOGS IN A USER INTO THEIR ACCOUT
     @param email : The user's email address
     @param password: The user's password
     @param completion -> Any: The single user obejct to be returned after the method call
    */
    static func signIn(_ email: String, _ password: String, completion: @escaping (Any) ->()){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {return completion(error.debugDescription)}
            show(completion: { (user) in
               return completion(user!)
            })
        }
    }
    
    
    /* THIS METHOD UPDATES A USER ACCOUNT
     @param newUser: The user object to be updated
     @param completion -> Any: The single user obejct to be returned after the method call
    */
    static func update(_ newUser: User,completion: @escaping (User)->()){
        let ref = Constant.user((Auth.auth().currentUser?.uid)!)
        
        ref.updateChildValues(newUser.toDictionary()) { (error, ref) in
            show { (user) in
                return completion(user!)
            }
        }
    }
    /// method to add google user to firrebase
    static func loginWithGoogle(googleUser: GIDGoogleUser, completion: @escaping(User?) -> ()){
        let profile = googleUser.profile
        
        var user = User.init((Auth.auth().currentUser?.displayName)!, "", (profile?.email)!)
        
        //let user = User(fn: (profile?.givenName)!, ln: (profile?.familyName)!, un: (profile?.name)!, deviceToken: "", accountType: "client", email: (profile?.email)!)
        if (profile?.hasImage)!{
            user.profileUrl = profile?.imageURL(withDimension: 300).absoluteString
        }
        
        show { (existingUser) in
            if existingUser == nil{
                create( user: user) { (created) in
                    if (created as? User != nil){
                        return completion(created as? User)
                    }
                    else{
                        print("couldn't create user")
                        completion(nil)
                    }
                }
            }
            else{
                return completion(existingUser)
            }
        }
    }
    
    
    static func loginWithFacebook(sender: UIViewController,completion: @escaping(User?)->()){


        FBSDKProfile.loadCurrentProfile(completion: { profile, error in
            if let profile = profile {
                guard let authUser = Auth.auth().currentUser else {
                    
                    return completion(nil)
                }

                var user = User.init(profile.name, "", Auth.auth().currentUser?.email ?? "")
                user.profileUrl = profile.imageURL(for: .square, size: CGSize(width: 100, height: 100)).absoluteString

                /// fetch user from database
                show(completion: { (databaseUser) in
                    if let databaseUser = databaseUser{
                        completion(databaseUser)
                    }
                    else{
                        /// create user if first time login
                        create(user: user, completion: { (createdUser) in

                            if let user = createdUser as? User{
                                completion(user)
                            }
                            else{
                                print("user wasn't create in the database")
                                completion(nil)
                            }
                        })
                    }
                })

            }
        })
    }
}
