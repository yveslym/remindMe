//
//  Reminder.swift
//  remindMe
//
//  Created by Medi Assumani on 9/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

struct Reminder{
    
    //var id: String
    var name: String
    var type: EventType?
    var time: String
    
    init(name: String, type: EventType, time: String) {
        
        self.name = name
        self.type = type
        self.time = time
    }
    
}
