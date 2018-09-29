//
//  EventType.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

// THIS ENUM DESCRIBE THE TYPE OF REMINDER, COULD BE ENTRY OR EXIT

enum EventType: String, Codable{
    
    case onEntry = "Entry"
    case onExit = "Exit"
}


