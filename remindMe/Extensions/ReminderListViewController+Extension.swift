//
//  ReminderListViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

extension ReminderListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    // function to return the num of rows on a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    
    
    // Function to handle action when a cell is selected
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reminderCell = tableView.dequeueReusableCell(withIdentifier: Constant.reminderTableViewCellIdentifier, for: indexPath) as! ReminderListTableViewCell
        
        
        
        return  reminderCell
    }
    
    
    
    
    // Function to delete a cell from the table view
    func tableView(_ tableview : UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            // code to delete a reminder from table view and database(FireBase)
        }
    }
}
