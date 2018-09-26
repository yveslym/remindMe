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
    
// THIS STRUCT CONTAINS FUNCTIONS TO CREATE, SHOW A GROUP AND TALK TO THE BACKEND
    

    static func show(completion: @escaping ([Group]?) ->()){
        
       
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
                completion(groups)
            })
        }
        
        
    }
    static func create(_ group: Group, completion: @escaping()->()){
        
        let ref = Constant.groupRef().childByAutoId()
        
        ref.setValue(group.toDictionary())
        
        completion()
    }
}
