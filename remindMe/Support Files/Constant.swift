//
//  Constant.swift
//  remindMe
//
//  Created by Yves Songolo on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

struct Constant{
    static func user(_ id: String)-> DatabaseReference{
        let ref = Database.database().reference().child("Users").child(id)
        return ref
    }
    static func reminder(_ id: String) -> DatabaseReference{
        let ref = Database.database().reference().child("Reminders").child(id)
        return ref
    }
    static func group(_ id: String) -> DatabaseReference{
        let ref = Database.database().reference().child("Groups").child(id)
        return ref
    }
    
}
