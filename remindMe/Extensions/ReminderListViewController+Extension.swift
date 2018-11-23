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
        return userReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = userReminders[indexPath.row]
        
         let reminderCell = tableView.dequeueReusableCell(withIdentifier: Constant.reminderTableViewCellIdentifier) as? ReminderListTableViewCell

        let reminderView = ReminderCustomView(frame: (reminderCell?.frame)!, reminder: reminder)
        
        reminderCell?.addSubview(reminderView)
//        reminderView.heightAnchor.constraint(equalTo: (reminderCell?.heightAnchor)!, multiplier: 1).isActive = true
//        reminderView.widthAnchor.constraint(equalTo: (reminderCell?.widthAnchor)!, multiplier: 1).isActive = true
//     
        reminderView.anchor(top: reminderCell?.topAnchor, left: reminderCell?.leftAnchor, bottom: reminderCell?.bottomAnchor, right: reminderCell?.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: (reminderCell?.frame.width)!, height: (reminderCell?.frame.height)!, enableInsets: false)
        //reminderView.backgroundColor = UIColor.clear
        reminderCell?.contentView.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 0.1025524401)
        return reminderCell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//       return "Remimders"
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//            let headerContainerView = UIView()
//            headerContainerView.frame = CGRect(x: 0, y: 0, width: 101, height: 31)
//            headerContainerView.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
//
//            let reminderHeaderLabel = UILabel()
//            reminderHeaderLabel.frame = CGRect(x: 10, y: 0, width: 101, height: 31)
//            reminderHeaderLabel.text = "Projects"
//            reminderHeaderLabel.font = UIFont(name: "AvenirNext-Bold", size: 23)
//            reminderHeaderLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//            reminderHeaderLabel.textAlignment = .left
//
//            headerContainerView.addSubview(reminderHeaderLabel)
//
//            return headerContainerView
//        }
//
//    // This method returns the number of rows on a table view
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return userReminders.count
//    }
//    
//    // This Method handles action when a cell is selected
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let reminderCell = tableView.dequeueReusableCell(withIdentifier: Constant.reminderTableViewCellIdentifier, for: indexPath) as! ReminderListTableViewCell
//        let reminder = userReminders[indexPath.row]
//        
//        reminderCell.reminderTitleLabel.text = reminder.name
//        reminderCell.reminderTypeLabel.text = reminder.type?.rawValue
//        
//        return  reminderCell
//    }
//    
//
//    // This Method deletes a cell from the table view when dragged from right to left
//    func tableView(_ tableview : UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            let reminderToBeDeleted = userReminders[indexPath.row]
//            ReminderServices.delete(reminderToBeDeleted) { (true) in
//                self.fetchAllReminders()
//            }
//        }
//    }
}
