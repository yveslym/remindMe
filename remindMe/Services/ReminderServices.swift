//
//  ReminderServices.swift
//  remindMe
//
//  Created by Medi Assumani on 9/26/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

// THIS STRUCT CONTAINS FUNCTIONS TO CREATE, SHOW A REMINDER AND TALK TO THE BACKEND

struct ReminderServices{
    
    static func show(completion: @escaping ([Reminder]?) -> ()){
        
        let reference = Constant.reminderRef()
        reference.observeSingleEvent(of: .value) { (snapshot) in
            var reminders = [Reminder]()
            let dispatchGroup = DispatchGroup()
            
            snapshot.children.forEach({ (nap) in
                
                dispatchGroup.enter()
                guard let snap = snapshot as? DataSnapshot else { return completion(nil) }
                let value = snap.value
                let reminder = try! JSONDecoder().decode(Reminder.self, withJSONObject: value!)
                reminders.append(reminder)
                dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .global(), execute: {
                completion(reminders)
            })
        }
    }
    
    static func create(_ reminder: Reminder, completion: @escaping()->()){
        
        let ref = Constant.reminderRef().childByAutoId()
        ref.setValue(reminder.toDictionary())
        completion()
    }
}
