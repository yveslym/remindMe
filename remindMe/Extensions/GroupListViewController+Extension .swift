//
//  GroupListViewController+Extension .swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

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
        clickedGroup = group
        
        groupCell.groupNameLabel.text = group.name
        groupCell.numberOfRemindersLabel.text = Group.numberOfReminders.convertIntToString()
        
        return groupCell
    }
    
    
    // Function to delete a cell from the table view
    func tableView(_ tableview : UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            // code to delete a group from the tableview and database(FireBase)
            //let groupToBeDeleted = userGroups[indexPath.row]
        }
        
    }
    
    //function to send a reference of the cliked group
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier, let destinationViewController = segue.destination as? ReminderListViewController else {return}
        
        switch segueIdentifier {
            //if the user clicks on a group
        case Constant.showAllRemindersSegueIdentifier:
            
            //send the group id that will be used when creating a reminder
            guard let groupId = clickedGroup?.id else {return}
            destinationViewController.groupId = groupId
            
        default:
            print("ERROR : INVALID SEGUE IDENTIFIER")
        }
    }

}
