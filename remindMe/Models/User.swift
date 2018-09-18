//
//  User.swift
//  remindMe
//
//  Created by Yves Songolo on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
struct User: Codable{
    var name: String
    var id: String
    var email: String
    
    func toDictionary() ->[String: Any]{
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    }
}
