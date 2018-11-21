//
//  Group.swift
//  remindMe
//
//  Created by Yves Songolo on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct Group: Codable{
    
    var id: String
    var name: String
    var description: String?
    var longitude: Double
    var latitude: Double
    
    init(id: String, name: String,description: String, latitude: Double, longitude: Double) {
        
        self.id = id
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
   
    func toDictionary() ->[String: Any]{
        let data = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        return json as! [String : Any]
    }
    
 
}
