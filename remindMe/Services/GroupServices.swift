
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
    
    ///METHOD TO GET ALL THE CREATED GROUPS FROM THE DATABASE TO THE CLIENT
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
    */
    static func create(_ group: Group, completion: @escaping(Group)->()){
        
        let ref = Constant.groupRef().childByAutoId()
        var g = group
        g.id = ref.key!
        ref.setValue(g.toDictionary()) { (error, ref) in
            
            show(g.id, completion: { (group) in
                
                completion(group!)
            })
        }
    }
    
    /// METHOD TO UPDATE A GROUP FROM THE CLIENT TO THE DATABASE
    static func update(_ group: Group, completion: @escaping()->()){
        let ref = Constant.groupRef().child(group.id)
       ref.updateChildValues(group.toDictionary())
        
        completion()
    }
    
    /** METHOD TO DELETE A GROUP FROM THE DATABASE
     @param group: the group to be removed
     */
    static func delete(group: Group, completion: @escaping(Bool)->()){
        let ref = Constant.showGroupRef(group.id)
        ref.removeValue { (error, ref) in
           return (error == nil) ? ( completion(true)) : (completion(false))
        }
    }
}



