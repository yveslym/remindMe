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
    static let current = {
        //fetch data from user default
        // check if user exist
            // if it does
                // decode into user
                    //return user
    }
    
    init(_ name: String, _ id: String, _ email: String){
        self.name = name
        self.id = id
        self.email = email
    }
   
    /// Function to persist the the user's data
    func persistUser(user: User){
        // turn user object into data type using jsonencoder()
        // save the data to userDefaults
        
    }
    
    /// Function to turn native data into JSON
    func toDictionary() ->[String: Any]{
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    }
}
