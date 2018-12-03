//
//  ReminderListViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

extension ReminderListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedReminder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = sortedReminder[indexPath.row]
        
         let reminderCell = tableView.dequeueReusableCell(withIdentifier: Constant.reminderTableViewCellIdentifier) as? ReminderListTableViewCell

        let reminderView = ReminderCustomView(frame: (reminderCell?.frame)!, reminder: reminder)
        
        reminderCell?.addSubview(reminderView)

        reminderView.anchor(top: reminderCell?.topAnchor,
                            left: reminderCell?.leftAnchor,
                            bottom: reminderCell?.bottomAnchor,
                            right: reminderCell?.rightAnchor,
                            paddingTop: 10, paddingLeft: 10,
                            paddingBottom: 5,
                            paddingRight: 10,
                            width: (reminderCell?.frame.width)!,
                            height: (reminderCell?.frame.height)!,
                            enableInsets: false)
        
      
        reminderCell?.contentView.backgroundColor = .lightCyan
        return reminderCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let headerContainerView = UIView()
            headerContainerView.frame = CGRect(x: 0, y: 0, width: 101, height: 31)
            headerContainerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
            var reminder = String()
        
        sortedReminder.count > 1 ? (reminder = "Reminders") : (reminder = "Reminder")
        
            let reminderHeaderLabel = UILabel()
            reminderHeaderLabel.frame = CGRect(x: 10, y: 0, width: self.view.frame.width, height: 31)
            reminderHeaderLabel.text = "\(sortedReminder.count) \(reminder)"
            reminderHeaderLabel.font = UIFont(name: "Rockwell", size: 18)
            reminderHeaderLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            reminderHeaderLabel.textAlignment = .left

            headerContainerView.addSubview(reminderHeaderLabel)

            return headerContainerView
        }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
    
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            let alert = UIAlertController(title: "Delete", message: " This reminder will be deleted, do you want to continue?", preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "Return", style: .cancel, handler: nil)
            let deleteButton = UIAlertAction(title: "Delete", style: .default, handler: { (remove) in
                let reminderToBeDeleted = self.sortedReminder[indexPath.row]
                ReminderServices.delete(reminderToBeDeleted)
            })
           alert.addAction(cancelButton)
            alert.addAction(deleteButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        let update = UITableViewRowAction(style: .default, title: "Update") { (action, indexPath) in
            // share item at indexPath
             let reminderToBeUpdated = self.sortedReminder[indexPath.row]
            let destination = NewReminderViewController()
            destination.userGroup = self.userGroup
            destination.userReminder = reminderToBeUpdated
            destination.modalPresentationStyle = .overCurrentContext
            destination.modalTransitionStyle = .crossDissolve
             self.present(destination, animated: true, completion: nil)
        }
        
        update.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        
        return [delete, update]
        
    }
    
}
