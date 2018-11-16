//
//  User.swift
//  remindMe
//
//  Created by Yves Songolo on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import Foundation
import FirebaseAuth

// THIS STRUCT REPERESENTS THE BLUE PRINTS OF THE USER DATA MODEL

struct User: Codable{
    var name: String
    var id: String
    var email: String
    var profileUrl: String?
    private static var _current: User?
    static var current: User{
        
        // check if user exist
        if let currentUser = _current{
            return currentUser
        }else{
            // decode into user
            let data = UserDefaults.standard.value(forKey: "current") as? Data
            let user = try! JSONDecoder().decode(User.self, from: data!)
            
            //return user
            return user
        }
    }
    
    init(_ name: String, _ id: String, _ email: String){
        self.name = name
        self.id = id
        self.email = email
    }
   
    
    /// Function to set and save the current user of the app to UserDefaults
    static func setCurrentUser(user: User, writeToUserDefaults: Bool = false){
        
        if writeToUserDefaults{
            if let data = try? JSONEncoder().encode(user){
                UserDefaults.standard.set(data, forKey: "current")
            }
        }
        _current = user
    }
  
    /// Function to turn native data into JSON to be sent to Firebase
    func toDictionary() ->[String: Any]{
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    }
}
