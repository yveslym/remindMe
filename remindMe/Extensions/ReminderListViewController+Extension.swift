//
//  ReminderListViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

extension ReminderListViewController: UITableViewDelegate, UITableViewDataSource{
    
    // function to return the num of rows on a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userReminders.count
    }
    
    // Function to handle action when a cell is selected
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reminderCell = tableView.dequeueReusableCell(withIdentifier: Constant.reminderTableViewCellIdentifier, for: indexPath) as! ReminderListTableViewCell
        let reminder = userReminders[indexPath.row]
        
        reminderCell.reminderTitleLabel.text = reminder.name
        reminderCell.reminderTypeLabel.text = reminder.type?.rawValue
        
        return  reminderCell
    }
    

    // Function to delete a cell from the table view
    func tableView(_ tableview : UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let reminderToBeDeleted = userReminders[indexPath.row]
            ReminderServices.delete(reminderToBeDeleted) { (true) in
                self.fetchAllReminders()
            }
        }
    }
}
