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
    
    init(_ name: String, _ id: String, _ email: String){
        self.name = name
        self.id = id
        self.email = email
    }
    
    func toDictionary() ->[String: Any]{
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    }
}
