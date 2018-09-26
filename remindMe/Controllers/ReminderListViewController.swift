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
    
    @IBOutlet weak var reminderTableView: UITableView!
    
    var dummyArray: [String] = ["Get Keys", "Lower Thermostat", "Feed Dog", "Activate Alarm"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderTableView.delegate = self as UITableViewDelegate
        reminderTableView.dataSource = self as UITableViewDataSource
    }
    
    
    
    // Function to unwind back to this view controller
    
    @IBAction func unwindToReminderListViewController(_ segue: UIStoryboardSegue){
        
    }
    

}
