//
//  ReminderServices.swift
//  remindMe
//
//  Created by Medi Assumani on 9/26/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

/// THIS STRUCT CONTAINS FUNCTIONS TO CREATE, SHOW A REMINDER AND TALK TO THE BACKEND
struct ReminderServices{

    /// METHOD THAT GETS AN ARRAY OF REMINDERS CREATED BY THE USER FROM THE DATABASE TO DISPLAY TO CLIENT
    static func index(completion: @escaping ([Reminder]?) -> ()){
        
        let reference = Constant.reminderRef()
        reference.observeSingleEvent(of: .value) { (snapshot) in
            var listOfReminders = [Reminder]()
            let dispatchGroup = DispatchGroup()
            if snapshot.exists() == false  {return completion(nil)}
           
                snapshot.children.forEach({ (snap) in
                    dispatchGroup.enter()
                    guard let snap = snap as? DataSnapshot else { return completion(nil) }
                    let value = snap.value
                    let data = try! JSONSerialization.data(withJSONObject: value!, options: [])
                    let reminder = try! JSONDecoder().decode(Reminder.self, from: data)
                    listOfReminders.append(reminder)
                    dispatchGroup.leave()
                })
                
                dispatchGroup.notify(queue: .global(), execute: {
                    completion(listOfReminders)
                })
            }
        }
    
    
    /** METHOD TO SHOW THE DATA OF A SINGLE REMINDER FROM THE DATABASE TO THE CLIENT
     @param : groupId : the group's id of needed to look it up on the database
     */
    func show(_ groupId: String, completion: @escaping([Reminder]) -> ()){
        //let reference = Constant.showReminderRef(<#T##id: String##String#>)
    }
   
    
    /**
     METHOD THAT CREATES A SINGLE REMINDER AND SENDS IT TO THE DATABASE
     @param reminder : the reminder to be created on the data base
    */
    static func create(_ reminder: Reminder, completion: @escaping()->()){
        
        let ref = Constant.reminderRef().childByAutoId()
        var mutatingReminder = reminder
        mutatingReminder.id = ref.key!
        ref.setValue(mutatingReminder.toDictionary())
        completion()
    }
    
    /**
     METHOD THAT UPDATES A REMINDER FROM THE CLIENT TO THE DATABASE
     @param group : the reminder to be updated
     */
    static func update(_ reminder: Reminder, completion: @escaping() -> ()){
        let reference = Constant.reminderRef().child(reminder.id)
        reference.updateChildValues(reminder.toDictionary())
        completion()
    }
    
    /**
     METHOD THAT DELETES A REMINDER FROM THE DATABASE
     @param group: the reminder to be removed
     */
    static func delete(_ reminder: Reminder, completion: @escaping(Bool) -> ()){
        let reference = Constant.showReminderRef(reminder.id)
        reference.removeValue { (error, reference) in
            return (error == nil) ? ( completion(true)) : (completion(false))
        }
    }
}
