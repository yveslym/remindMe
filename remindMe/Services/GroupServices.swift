
//
//  GroupServices.swift
//  remindMe
//
//  Created by Yves Songolo on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//
import Foundation
import Firebase


struct GroupServices{
    
    /*METHOD TO GET ALL THE CREATED GROUPS FROM THE DATABASE TO THE CLIENT
     @param completion ->[Group]: The list of group objects to be returned after the method call
    */
    static func index(completion: @escaping ([Group]?) ->()){
        
        let ref = Constant.groupRef()
        ref.observeSingleEvent(of: .value) { (snapshot) in
            var groups = [Group]()
            let dg = DispatchGroup()
            
            snapshot.children.forEach({ (snap) in
                
                dg.enter()
                guard let snap = snap as? DataSnapshot else {return completion(nil)}
                let value = snap.value
                let group = try! JSONDecoder().decode(Group.self, withJSONObject: value!)
                groups.append(group)
                dg.leave()
            })
            
            dg.notify(queue: .global(), execute: {
                return completion(groups)
            })
        }
    }
    
    /** METHOD TO SHOW THE DATA OF A SINGLE GROUP FROM THE DATABASE TO THE CLIENT
     @param : groupId : the group's id of needed to look it up on the database
     @param completion -> Group: The single group object to be returned after the method call
    */
    static func show (_ groupId: String, completion: @escaping(Group?)->()){
        
        let ref = Constant.showGroupRef(groupId)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists(){
                let group = try! JSONDecoder().decode(Group.self, withJSONObject: snapshot.value!, options: [])
                return completion(group)
            }
            else{
                return completion(nil)
            }
        }
    }
    
    
    /** METHOD TO CREATE A SINGLE GROUP OBJECT AND SAVE IT INTO THE DATABASE
     @param group : the group to be created in the database
     @param completion -> Group: The single of group obejct to be returned after the method call
    */
    static func create(_ group: Group, completion: @escaping(Group)->()){
        
        let ref = Constant.groupRef().childByAutoId()
        var newGroup = group
        newGroup.id = ref.key!
        ref.setValue(newGroup.toDictionary()) { (error, ref) in
            show(newGroup.id, completion: { (group) in
                guard let unWrappedGroup = group else {return}
                completion(unWrappedGroup)
            })
        }
    }
    
    
    /* METHOD TO UPDATE A GROUP FROM THE CLIENT TO THE DATABASE
    @param group : The group to be updated by the user
    */
    static func update(_ group: Group, completion: @escaping()->()){
        
        // Grabs the reference of the group from FireBase and updates it
        let ref = Constant.groupRef().child(group.id)
        ref.updateChildValues(group.toDictionary())
        completion()
    }
    
    
    /** METHOD TO DELETE A GROUP FROM THE DATABASE
     @param group: the group to be removed
     @param completion ->Bool: The true or false value that determine wheter the group has been deleted
     */
    static func delete(group: Group, completion: @escaping(Bool)->()){
        
        // Fetches all reminders of the user
        ReminderServices.index { (reminders) in
            
            if let reminders = reminders{
                
                // loops into the list of reminders
                reminders.forEach({ (reminder) in
                    
                    // if the reminder has the same group id of the group that will be deleted...
                    if reminder.groupId == group.id{
                        // the reminder gets deleted
                        ReminderServices.delete(reminder, completion: { (true) in
                            print("Reminder of group \(group.name) successfully deleted")
                        })
                    }
                })
            }
        }
        
        // Grabs the reference of the group from FireBase and deletes it
        let ref = Constant.showGroupRef(group.id)
        ref.removeValue { (error, ref) in
           return (error == nil) ? ( completion(true)) : (completion(false))
        }
    }
}



