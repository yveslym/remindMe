//
//  ReminderListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class ReminderListViewController: UIViewController{
    // This View Controller class handles functionality to show the list of all the reminders
    

    
//    var userReminders = [Reminder](){
//        didSet{
//            DispatchQueue.main.async {
//                self.reminderTableView.reloadData()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetchAllReminders()
    }
    
    // THIS FUNCTION MAKES AN API CALL TO GET ALL REMINDERS FROM THE CLIENT SIDE
//    internal func fetchAllReminders(){
//        ReminderServices.index { (reminders) in
//            guard let reminders = reminders  else {return}
//            reminders.forEach({ (reminder) in
//                if reminder.groupId == self.parentGroup?.id{
//                    self.userReminders.append(reminder)
//                }
//            })
//        }
//    }
    
//    // Function to unwind back to this view controller
//    @IBAction func unwindToReminderListViewController(_ segue: UIStoryboardSegue){
//        fetchAllReminders()
//    }
}
