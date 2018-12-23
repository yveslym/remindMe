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
    
    // NEEDED STATIC VARIABLES FOR THE STORY BOARD
    
    static let groupTableViewCellIdentifier: String = "groupCell"
    static let reminderTableViewCellIdentifier: String = "reminderCell"
    static let onboardingViewCellIdentifier: String = "onboardingCellId"
    static let days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday","Every day"]
    
    /// This function is used to set up an alert to show to the user in case we need to warn the user
    static func setUpAlert(alertTitle: String,
                         alertMessage: String,
                         alertStyle: UIAlertControllerStyle,
                         actionTitle: String,
                         actionStyle: UIAlertActionStyle){
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: alertStyle)
        let action = UIAlertAction(title: actionTitle, style: actionStyle, handler: nil)
        
        alert.addAction(action)
    }
    
    // NEEDED STATIC FUNCTIONS FOR THE DATABASE
    
    static func user(_ id: String)-> DatabaseReference{
        let ref = Database.database().reference().child("Users").child(id)
        return ref
    }
    
    
    static func reminder(_ id: String) -> DatabaseReference{
        let ref = Database.database().reference().child("Reminders").child(id)
        return ref
    }
    
    
    static func showGroupRef(_ id: String) -> DatabaseReference{
        let ref = Database.database().reference().child("Groups").child((Auth.auth().currentUser?.uid)!).child(id)
        return ref
    }
    
    static func showReminderRef(_ id: String) -> DatabaseReference{
        let ref = Database.database().reference().child("Reminders").child((Auth.auth().currentUser?.uid)!).child(id)
        return ref
    }
    
    
    static func groupRef() -> DatabaseReference{
        let ref = Database.database().reference().child("Groups").child((Auth.auth().currentUser?.uid)!)
        return ref
    }
    
    static func reminderRef() -> DatabaseReference{
        let ref = Database.database().reference().child("Reminders").child((Auth.auth().currentUser?.uid)!)
        return ref
    }
    
}
