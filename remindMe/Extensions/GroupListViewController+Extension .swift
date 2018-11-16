//
//  GroupListViewController+Extension .swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

//import UIKit
//
//extension GroupListViewController: UITableViewDelegate, UITableViewDataSource{
//    
//    // This Function returns the number of rows on a table view
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return userGroups.count
//    }
//
//    // This Function handles action when a cell is selected
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let groupCell = tableView.dequeueReusableCell(withIdentifier: Constant.groupTableViewCellIdentifier, for: indexPath) as! GroupListTableViewCell
//        let group = userGroups[indexPath.row]
//        groupCell.groupNameLabel.text = group.name
//        groupCell.numberOfRemindersLabel.text = "\(Reminder.totalAmountOfReminders.convertIntToString()) reminder"
//
//        return groupCell
//    }
//
//
//    // This Function deletes a cell from the table view when dragged from right to left
//    func tableView(_ tableview : UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete{
//            let groupToBeDeleted = userGroups[indexPath.row]
//            GroupServices.delete(group: groupToBeDeleted) { (true) in
//                self.fetchAllGroups()
//            }
//        }
//    }
//
//    // This function performs a segue to the list of reminders of the selected group
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let group = userGroups[indexPath.row]
//        self.performSegue(withIdentifier: Constant.showAllRemindersSegueIdentifier, sender: group)
//    }
//
//    // This function sends a reference of the group object selected to be used in the next view controller
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        guard let segueIdentifier = segue.identifier else {return}
//        switch segueIdentifier {
//        case Constant.showAllRemindersSegueIdentifier:
//
//            let destinationViewController = segue.destination as? ReminderListViewController
//            let group = sender as? Group
//            destinationViewController?.parentGroup = group
//        default:
//            print("ERROR : INVALID SEGUE IDENTIFIER")
//        }
//    }
//}
