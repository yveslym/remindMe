//
//  ReminderServices.swift
//  remindMe
//
//  Created by Medi Assumani on 9/26/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Firebase

struct ReminderServices{
    /* Implements The CRUD Services of a Reminder model
    
    Methods :
    - index : fetches all user's reminders
    - show : shows a single reminder
    - create : creates a single reminder
    - update : updates a single reminder
    - delete : deletes a single reminder
    */
    

    /* METHOD THAT GETS AN ARRAY OF REMINDERS CREATED BY THE USER FROM THE DATABASE TO DISPLAY TO CLIENT
     @param completion ->[Reminder]: The list of reminder objects to be returned after the method call
    */
    static func index(completion: @escaping ([Reminder]?) -> ()){
        
        let reference = Constant.reminderRef()
        reference.observeSingleEvent(of: .value) { (snapshot) in
            var listOfReminders = [Reminder]()
            let dispatchGroup = DispatchGroup()
            if snapshot.exists() == false  {return completion(nil)}
           
                snapshot.children.forEach({ (snap) in
                    dispatchGroup.enter()
                    guard let snap = snap as? DataSnapshot else { return completion(nil) }
                    guard let SnapchotValue = snap.value else {return}
                    let encodedData = try! JSONSerialization.data(withJSONObject: SnapchotValue, options: [])
                    let reminder = try! JSONDecoder().decode(Reminder.self, from: encodedData)
                    listOfReminders.append(reminder)
                    dispatchGroup.leave()
                })
                
                dispatchGroup.notify(queue: .global(), execute: {
                    completion(listOfReminders)
                })
            }
        }
    
    
    /** METHOD TO RETURN AN ARRAY OF REMINDERS WITH THE GIVEN GROUP ID FROM THE DATABASE
     @param : groupId : the reminder's id of needed to look it up on the database
     @param completion -> [Reminder]: The list of  reminder objects to be returned after the method call
     */
    static func indexByGroupId(groupId: String, completion: @escaping([Reminder]?) -> ()){
        
        let reference = Constant.reminderRef()
        reference.observeSingleEvent(of: .value) { (snapshot) in
            var listOfReminders = [Reminder]()
            let dispatchGroup = DispatchGroup()
            if snapshot.exists() == false {return completion(nil)}
            
            snapshot.children.forEach({ (snap) in
                dispatchGroup.enter()
                guard let snap = snap as? DataSnapshot  else {return completion(nil)}
                guard let snapshotValue = snap.value else {return}
                let encodedData = try! JSONSerialization.data(withJSONObject: snapshotValue, options: [])
                let reminder = try! JSONDecoder().decode(Reminder.self, from: encodedData)
                
                if reminder.groupId == groupId{
                    listOfReminders.append(reminder)
                }
                dispatchGroup.leave()
            })
            
            dispatchGroup.notify(queue: .global(), execute: {
                completion(listOfReminders)
            })
        }
    }
    
    
    /** METHOD TO SHOW THE DATA OF A SINGLE REMINDER FROM THE DATABASE TO THE CLIENT
     @param : reminderId : the reminder's id of needed to look it up on the database
     @param completion -> Reminder: The single reminder object to be returned after the method call
     */
    static func show(_ reminderId: String, completion: @escaping(Reminder?) -> ()){
        
        let reference = Constant.showReminderRef(reminderId)
        reference.observeSingleEvent(of: .value) { (snapchot) in
            if snapchot.exists(){
                let reminder = try! JSONDecoder().decode(Reminder.self, withJSONObject: snapchot.value as Any, options: [])
                return completion(reminder)
            }else {
                return completion(nil)
            }
        }
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
     @param completion ->Bool: The true or false value that determine wheter the reminder has been deleted
     */
    static func delete(_ reminder: Reminder){
        
        let reference = Constant.showReminderRef(reminder.id)
        reference.removeValue()
    }
    
    static func update(_ reminder: Reminder){
        Constant.showReminderRef(reminder.id).updateChildValues(reminder.toDictionary())
     
    }
    
    /// method to check if the reminder is onnthe time constrain to set by the user to recieve notificartion
  static func isReminderOnTimeFrame(reminder: Reminder) -> Bool{
        guard let date = Date().timeToString().toDateTime() else{return false}
        let day = Date().dayOfWeek()
    if day == reminder.day{
        
    
         guard let timeFrom = reminder.timeFrom?.toDateTime() else{return false}
         guard let timeTo = reminder.timeTo?.toDateTime() else{return false}
        
      return (timeFrom <= date) && (timeTo >= date ) ?  true :  false
    }
    else{
        return false
    }
    
}
    
    /// method to observe new cerated reminders on database
    static func observeAddedReminder(completion: @escaping (Reminder)->()){
        Constant.reminderRef().observe(.childAdded) { (snapshot) in
            if snapshot.exists(){
                do{
                    let reminder = try JSONDecoder().decode(Reminder.self, withJSONObject: snapshot.value as Any)
                    completion(reminder)
                }
                catch{
                    print("couldn't decode observed entry reminder")
                    }
                }
        }
    }
    /// method to observe updated reminders on database
    static func observeUpdatedReminder(completion: @escaping ([Reminder]?)->()){
        Constant.reminderRef().observe(.childChanged) { (snapshot) in
            if snapshot.exists(){
                index(completion: { (reminders) in
                    completion(reminders)
                })
            }
        }
    }
    /// method to observe removed reminders
    static func observeRemovedReminder(completion: @escaping ([Reminder]?)->()){
        Constant.reminderRef().observe(.childRemoved) { (snapshot) in
            if snapshot.exists(){
                index(completion: { (reminders) in
                    completion(reminders)
                })
            }
        }
    }
}
