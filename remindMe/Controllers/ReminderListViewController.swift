//
//  ReminderListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

// This VC is to show the list of all the reminders
class ReminderListViewController: UIViewController{
    
    
    // - MARK: @IBOULETS AND PROPERTIES
    @IBOutlet weak var reminderTableView: UITableView!
    var parentGroup: Group?
    
    var userReminders = [Reminder](){
        didSet{
            DispatchQueue.main.async {
                self.reminderTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETTING UP THE TABLE VIEW
        reminderTableView.delegate = self as UITableViewDelegate
        reminderTableView.dataSource = self as UITableViewDataSource
        fetchAllReminders()
    }
    
    // THIS FUNCTION MAKES AN API CALL TO GET ALL REMINDERS
    internal func fetchAllReminders(){
        ReminderServices.index { (reminders) in
            guard let reminders = reminders  else {return}
            self.userReminders = reminders.filter({$0.id == self.parentGroup?.id})
        }
    }
    
    // Function to unwind back to this view controller
    @IBAction func unwindToReminderListViewController(_ segue: UIStoryboardSegue){
        fetchAllReminders()
    }
}
