//
//  GroupListViewController+Extension .swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

extension GroupListViewController: UITableViewDelegate, UITableViewDataSource{
    
    // function to return the num of rows on a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userGroups.count
    }
    
    // Function to handle action when a cell is selected
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupCell = tableView.dequeueReusableCell(withIdentifier: Constant.groupTableViewCellIdentifier, for: indexPath) as! GroupListTableViewCell
        let group = userGroups[indexPath.row]
        
        groupCell.groupNameLabel.text = group.name
        groupCell.numberOfRemindersLabel.text = "2"
        
        return groupCell
    }
    
    
    // Function to delete a cell from the table view
    func tableView(_ tableview : UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            // code to delete a group from the tableview and database(FireBase)
            //let groupToBeDeleted = userGroups[indexPath.row]
        }
        
    }
}
