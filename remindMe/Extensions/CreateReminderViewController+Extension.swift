//
//  CreateReminderViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

extension CreateReminderViewController: UITextFieldDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier, let destinationViewController = segue.destination as? ReminderListViewController else {return}
        
        switch segueIdentifier {
            
        case Constant.saveReminderSegueIdenfier where reminder == nil:
            
            guard let name = reminderNameTextField.text, let type = reminderTypeTextFiled.text, let time = reminderTimeTextField.text else {return}
            
            // get reference to the group the reminder belongs to
            // get the groupId
            let createdReminder = Reminder(groupId: "", name: name, type: EventType(rawValue: type) ?? .onEntry, time: time)
    
            Group.numberOfReminders += 1
            ReminderServices.create(createdReminder) {
                DispatchQueue.main.async {
                    destinationViewController.userReminders.append(createdReminder)
                }
            }
            
        default:
            print("Unindentified Indentifier")
        }
        
    }
    

    // FUNCTION TO SELECT THE NEXT TEXTFIELD TO PROMPT FOR INPUT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case reminderNameTextField:
            
            reminderTypeTextFiled.becomeFirstResponder()
            
        case reminderTypeTextFiled:
            
            reminderTimeTextField.becomeFirstResponder()
            
        default:
            
            reminderTimeTextField.resignFirstResponder()
        }
        
        return true
    }
    
}
