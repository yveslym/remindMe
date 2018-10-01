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
import FBSDKLoginKit

// THIS STRUCT CONTAINS FUNCTIONS TO CREATE, SHOW, SIGNIN, SIGNUP A USER AND TALK TO THE BACKEND

struct UserServices{
    
    // THIS METHOD CREATES A SINGLE USER OBJECT AND STORES IT IN THE DATABASE
   private static func create(user: User, completion: @escaping(Any)->()){
        
        let authUser = Auth.auth().currentUser
       
        let ref = Constant.user((authUser?.uid)!) //Database.database().reference().child("Users").child((authUser?.uid)!)
        ref.setValue(user.toDictionary()) { (error, _) in
            if error != nil{
                return completion(error!)
            }
            return completion(user)
        }
}
    // THIS METHOD RETRIEVE USER FROM THE DATABASE
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


static func signUp(_ email: String, _ password: String, completion: @escaping (Any)->()){
    Auth.auth().createUser(withEmail: email, password: password) { (authUser, error) in
        guard authUser != nil else {return completion(error!)}
       
        let user = User.init("", (authUser?.user.uid)!, (authUser?.user.email!)!)
        create(user: user, completion: { (newUser) in
            if (newUser as? User) != nil{
                show(completion: { (user) in
                    return completion(user)
                })
            }
        })
        
    }
 }
}
